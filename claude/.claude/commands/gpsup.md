Analise as mudanças do repositório atual:

Status:
!`git status`

Diff:
!`git diff`

Siga este fluxo:

Se o modo atual for "accept edits", execute todos os passos diretamente sem pedir confirmações. Caso contrário, peça aprovação a cada etapa.

1. Com base nas mudanças, proponha um nome de branch seguindo gitflow:
   - `feature/` — nova funcionalidade
   - `fix/` — correção de bug
   - `hotfix/` — correção urgente em produção
   - `chore/` — manutenção, dependências, configuração
   - `refactor/` — refatoração sem mudança de comportamento
   Se não estiver em "accept edits", confirme o nome com o usuário antes de criar.

2. Execute `git checkout -b <branch>`.

3. Stage e commit seguindo conventional commits:
   - `feat:`, `fix:`, `chore:`, `refactor:`, `docs:`, `test:`

4. Execute `git push -u origin <branch>`.
