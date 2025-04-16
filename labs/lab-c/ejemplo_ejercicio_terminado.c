#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_NOTES 100
#define MAX_TITLE 64
#define MAX_BODY 256

typedef struct {
    char *title;
    char *body;
} Note;

typedef struct {
    Note *notes[MAX_NOTES];
    int count;
} NoteManager;

void read_line(char *buffer, size_t size) {
    if (fgets(buffer, size, stdin)) {
        buffer[strcspn(buffer, "\n")] = '\0';
    }
}

Note *create_note() {
    char title[MAX_TITLE];
    char body[MAX_BODY];

    printf("Titulo: ");
    read_line(title, sizeof(title));

    printf("Cuerpo: ");
    read_line(body, sizeof(body));

    Note *n = malloc(sizeof(Note));
    if (!n) {
        fprintf(stderr, "Error de asignación\n");
        return NULL;
    }

    n->title = strdup(title);
    n->body = strdup(body);

    if (!n->title || !n->body) {
        fprintf(stderr, "Error de asignación\n");
        free(n->title);
        free(n->body);
        free(n);
        return NULL;
    }

    return n;
}

void add_note(NoteManager *mgr) {
    if (mgr->count >= MAX_NOTES) {
        printf("Ya hay demasiadas notas!\n");
        return;
    }

    Note *n = create_note();
    if (n) {
        mgr->notes[mgr->count++] = n;
        printf("Nota añadida!\n");
    }
}

void view_note(NoteManager *mgr) {
    int index;
    printf("Indice de la nota buscada: ");
    if (scanf("%d%*c", &index) != 1) {
        printf("Entrada invalida.\n");
        return;
    }

    if (index < 0 || index >= mgr->count) {
        printf("Indice invalido!\n");
        return;
    }

    Note *n = mgr->notes[index];
    if (!n) {
        printf("La nota fue eliminada!\n");
        return;
    }

    printf("Titulo: %s\nCuerpo: %s\n", n->title, n->body);
}

void delete_note(NoteManager *mgr) {
    int index;
    printf("Indice de la nota a eliminar: ");
    if (scanf("%d%*c", &index) != 1) {
        printf("Entrada invalida.\n");
        return;
    }

    if (index < 0 || index >= mgr->count || !mgr->notes[index]) {
        printf("Indice invalido!\n");
        return;
    }

    free(mgr->notes[index]->title);
    free(mgr->notes[index]->body);
    free(mgr->notes[index]);
    mgr->notes[index] = NULL;

    printf("Nota borrada.\n");
}

void save_notes(NoteManager *mgr) {
    FILE *fp = fopen("notes.dat", "w");
    if (!fp) {
        perror("No se pudo abrir el archivo");
        return;
    }

    for (int i = 0; i < mgr->count; ++i) {
        if (mgr->notes[i]) {
            fprintf(fp, "%s\n", mgr->notes[i]->title);
            fprintf(fp, "%s\n", mgr->notes[i]->body);
        }
    }

    fclose(fp);
    printf("Notas guardadas.\n");
}

void load_notes(NoteManager *mgr) {
    FILE *fp = fopen("notes.dat", "r");
    if (!fp) {
        perror("No se pudo abrir el archivo");
        return;
    }

    char title[MAX_TITLE];
    char body[MAX_BODY];

    while (fgets(title, sizeof(title), fp) && fgets(body, sizeof(body), fp)) {
        if (mgr->count >= MAX_NOTES) break;

        title[strcspn(title, "\n")] = '\0';
        body[strcspn(body, "\n")] = '\0';

        Note *n = malloc(sizeof(Note));
        if (!n) continue;

        n->title = strdup(title);
        n->body = strdup(body);

        if (!n->title || !n->body) {
            free(n->title);
            free(n->body);
            free(n);
            continue;
        }

        mgr->notes[mgr->count++] = n;
    }

    fclose(fp);
    printf("Notas cargadas.\n");
}

void free_all_notes(NoteManager *mgr) {
    for (int i = 0; i < mgr->count; ++i) {
        if (mgr->notes[i]) {
            free(mgr->notes[i]->title);
            free(mgr->notes[i]->body);
            free(mgr->notes[i]);
        }
    }
}

void menu(NoteManager *mgr) {
    while (1) {
        printf("\n1. Agregar\n2. Ver\n3. Borrar\n4. Guardar\n5. Cargar\n6. Salir\n> ");
        int choice;
        if (scanf("%d%*c", &choice) != 1) {
            printf("Entrada invalida\n");
            break;
        }

        switch (choice) {
            case 1: add_note(mgr); break;
            case 2: view_note(mgr); break;
            case 3: delete_note(mgr); break;
            case 4: save_notes(mgr); break;
            case 5: load_notes(mgr); break;
            case 6:
                free_all_notes(mgr);
                return;
            default: printf("Opción no válida.\n");
        }
    }
}

int main() {
    NoteManager mgr = { .count = 0 };
    menu(&mgr);
    return 0;
}
