Analise as mudanças para descrever um Pull Request.

Status:
!`git status`

Branches disponíveis:
!`git branch -a`

$ARGUMENTS pode conter duas branches no formato `<base> <compare>`. Se não informado, detecte a branch atual pelo status e use a branch base padrão do repositório (geralmente main ou master).

Log:
!`git log <base>..<compare> --oneline`

Diff:
!`git diff <base>...<compare>`

Arquivos alterados:
!`git diff --name-only <base>...<compare>`

---

Gere título e descrição para Pull Request:

**Título:**
- Imperativo, ≤72 chars
- Formato: `<type>: <resumo>`
- Se houver mudança em arquivos de versionamento (VERSION, version.txt, package.json version, pyproject.toml, Cargo.toml, etc.), prefixe com a versão: `v1.2.3 — <type>: <resumo>`
- Sem ponto final

**Descrição (markdown):**
- `## O que mudou` — bullets curtos
- `## Por quê` — só se não for óbvio pelo diff
- Sem fluff, sem AI attribution

Mostre apenas título e descrição prontos para colar.
