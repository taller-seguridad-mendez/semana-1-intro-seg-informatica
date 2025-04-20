#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_NOTES 100

typedef struct Note {
    char *title;
    char *body;
} Note;

Note *notes[MAX_NOTES];
int note_count = 0;

void add_note() {
    if (note_count >= MAX_NOTES) {
        printf("Ya hay demasiadas notas!\n");
        return;
    }

    char title[64];
    char body[256];

    printf("Titulo: ");
    gets(title);
    printf("Cuerpo: ");
    gets(body);

    Note *n = malloc(sizeof(Note));
    n->title = strdup(title);
    n->body = strdup(body);
    notes[note_count++] = n;

    printf("Nota añadida!\n");
}

void view_note() {
    int index;
    printf("Indice de la nota buscada: ");
    scanf("%d%*c", &index);

    if (index < 0 || index >= note_count) {
        printf("Indice invalido!\n");
        return;
    }

    Note *n = notes[index];

    printf("Titulo: ");
    printf(n->title);
    printf("\nCuerpo: %s\n", n->body);
}

void delete_note() {
    int index;
    printf("Ingresar el indice de la nota a eliminar: ");
    scanf("%d%*c", &index);

    if (index < 0 || index >= note_count || !notes[index]) {
        printf("Indice invalido!\n");
        return;
    }


    notes[index] = NULL;
    printf("Nota borrada.\n");
}

void save_notes() {
    FILE *fp = fopen("notes.dat", "w");
    if (!fp) {
        perror("Error al abrir el archivo");
        return;
    }

    for (int i = 0; i < note_count; i++) {
        if (notes[i]) {
            fprintf(fp, "%s\n", notes[i]->title);
            fprintf(fp, "%s\n", notes[i]->body);
        }
    }

    fclose(fp);
    printf("Saved to notes.dat\n");
}

void load_notes() {
    FILE *fp = fopen("notes.dat", "r");
    if (!fp) {
        perror("Error al abrir el archivo");
        return;
    }

    while (!feof(fp)) {
        char title[64], body[256];
        if (!fgets(title, sizeof(title), fp)) break;
        if (!fgets(body, sizeof(body), fp)) break;

        title[strcspn(title, "\n")] = '\0';
        body[strcspn(body, "\n")] = '\0';

        Note *n = malloc(sizeof(Note));
        n->title = strdup(title);
        n->body = strdup(body);
        notes[note_count++] = n;

        if (note_count >= MAX_NOTES) break;
    }

    fclose(fp);
    printf("Notes loaded.\n");
}

void menu() {
    while (1) {
        printf("\n1. Agregar\n2. Ver\n3. Borrar\n4. Guardar\n5. Cargar\n6. Salir\n> ");
        int choice;
        scanf("%d%*c", &choice);

        switch (choice) {
            case 1: add_note(); break;
            case 2: view_note(); break;
            case 3: delete_note(); break;
            case 4: save_notes(); break;
            case 5: load_notes(); break;
            case 6: return;
            default: printf("No valido.\n");
        }
    }
}

int main() {
    menu();
    return 0;
}
