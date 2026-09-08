const express = require("express");
const path = require("path");
const db = require("./db");

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.json());

// Serve frontend
app.use(express.static(path.join(__dirname, "frontend")));

// Create notes table when server starts
async function initializeDatabase() {
    try {
        await db.execute(`
            CREATE TABLE IF NOT EXISTS notes (
                id INT AUTO_INCREMENT PRIMARY KEY,
                title VARCHAR(255) NOT NULL,
                content TEXT NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        `);

        console.log("MySQL database connected successfully.");
        console.log("Notes table is ready.");
    } catch (error) {
        console.error("Database connection failed:", error.message);
    }
}

// Health check
app.get("/api/health", (req, res) => {
    res.json({
        status: "ok",
        service: "CloudNotes",
        message: "Backend is running successfully"
    });
});

// Get all notes
app.get("/api/notes", async (req, res) => {
    try {
        const [rows] = await db.execute(
            "SELECT * FROM notes ORDER BY created_at DESC"
        );

        res.json(rows);
    } catch (error) {
        console.error(error);

        res.status(500).json({
            error: "Failed to fetch notes"
        });
    }
});

// Add a new note
app.post("/api/notes", async (req, res) => {
    try {
        const { title, content } = req.body;

        if (!title || !content) {
            return res.status(400).json({
                error: "Title and content are required"
            });
        }

        const [result] = await db.execute(
            "INSERT INTO notes (title, content) VALUES (?, ?)",
            [title, content]
        );

        res.status(201).json({
            id: result.insertId,
            title,
            content,
            message: "Note added successfully"
        });

    } catch (error) {
        console.error(error);

        res.status(500).json({
            error: "Failed to add note"
        });
    }
});

// Delete a note
app.delete("/api/notes/:id", async (req, res) => {
    try {
        const { id } = req.params;

        await db.execute(
            "DELETE FROM notes WHERE id = ?",
            [id]
        );

        res.json({
            message: "Note deleted successfully"
        });

    } catch (error) {
        console.error(error);

        res.status(500).json({
            error: "Failed to delete note"
        });
    }
});

// Start server
app.listen(PORT, "0.0.0.0", async () => {
    console.log(`CloudNotes server running on http://localhost:${PORT}`);

    await initializeDatabase();
});