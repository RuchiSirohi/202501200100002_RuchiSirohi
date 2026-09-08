const notesContainer = document.getElementById("notes-container");

// Load notes from MySQL through backend
async function loadNotes() {
    try {
        const response = await fetch("/api/notes");

        if (!response.ok) {
            throw new Error("Failed to load notes");
        }

        const notes = await response.json();

        notesContainer.innerHTML = "";

        if (notes.length === 0) {
            notesContainer.innerHTML = "<p>No notes yet. Create your first note!</p>";
            return;
        }

        notes.forEach(note => {
            const noteCard = document.createElement("div");
            noteCard.className = "note-card";

            noteCard.innerHTML = `
                <h3>${note.title}</h3>
                <p>${note.content}</p>
                <button onclick="deleteNote(${note.id})">Delete</button>
            `;

            notesContainer.appendChild(noteCard);
        });

    } catch (error) {
        notesContainer.innerHTML =
            "<p>Unable to load notes.</p>";

        console.error("Error loading notes:", error);
    }
}


// Add a new note to MySQL
async function addNote() {
    const titleInput = document.getElementById("title");
    const contentInput = document.getElementById("content");

    const title = titleInput.value.trim();
    const content = contentInput.value.trim();

    if (!title || !content) {
        alert("Please enter both title and content.");
        return;
    }

    try {
        const response = await fetch("/api/notes", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                title: title,
                content: content
            })
        });

        const data = await response.json();

        if (!response.ok) {
            throw new Error(data.error || "Failed to add note");
        }

        alert("Note added successfully!");

        titleInput.value = "";
        contentInput.value = "";

        // Refresh notes
        loadNotes();

    } catch (error) {
        console.error("Error adding note:", error);
        alert("Unable to add note.");
    }
}


// Delete a note from MySQL
async function deleteNote(id) {
    try {
        const response = await fetch(`/api/notes/${id}`, {
            method: "DELETE"
        });

        if (!response.ok) {
            throw new Error("Failed to delete note");
        }

        alert("Note deleted successfully!");

        // Refresh notes
        loadNotes();

    } catch (error) {
        console.error("Error deleting note:", error);
        alert("Unable to delete note.");
    }
}


// Load notes when page opens
loadNotes();