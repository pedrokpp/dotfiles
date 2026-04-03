Analise as mudanças do repositório atual:

Status:
!`git status`

Diff:
!`git diff`

Siga este fluxo:

1. Com base nas mudanças, proponha um nome de branch seguindo gitflow:
   - `feature/` — nova funcionalidade
   - `fix/` — correção de bug
   - `hotfix/` — correção urgente em produção
   - `chore/` — manutenção, dependências, configuração
   - `refactor/` — refatoração sem mudança de comportamento
   Confirme o nome com o usuário antes de criar.

2. Execute `git checkout -b <branch>`.

3. Stage e commit seguindo conventional commits:
   - `feat:`, `fix:`, `chore:`, `refactor:`, `docs:`, `test:`
   Mostre o comando de commit para aprovação antes de executar.

4. Pergunte se quer fazer push: `git push -u origin <branch>`.
