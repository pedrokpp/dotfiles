Analise as mudanças do repositório atual:

Status:
!`git status`

Diff:
!`git diff`

Siga este fluxo:

1. Use a skill `/caveman:caveman-commit` para gerar a mensagem de commit.

2. Stage e commit com a mensagem gerada.
   Se o modo atual for "accept edits", execute diretamente. Caso contrário, mostre o comando para aprovação antes de executar.

3. Pergunte se quer fazer push: `git push -u origin <branch>`.
   Se o modo atual for "accept edits", execute o push diretamente sem perguntar.
