# Claude Code Agentic Environment Setup

Claude Code를 자동화된 학습, 기억, 최적화 환경으로 구성하는 파이프라인입니다.

## Features

- **자동 학습**: 프로젝트 분석 결과를 자동으로 기억
- **반복 작업 자동화**: 3회 이상 반복된 작업은 커맨드로 제안
- **지식 관리**: 최적화 결과, 에러 해결, 기술 결정 등을 체계적으로 저장
- **맞춤 상호작용**: 모호한 요청 처리, 변경 사항 표시 등 개인화
- **모드 감지**: 요청 유형에 따른 자동 모드 전환 (explore/fix/explain/plan)

---

## Quick Start

### Step 1: 레포지토리 클론

```bash
git clone https://github.com/hjinnkim/claude-code-setup.git
cd claude-code-setup
```

### Step 2: config.yaml 수정

```bash
vi config.yaml  # 또는 원하는 에디터
```

### Step 3: 셋업 실행

```bash
chmod +x setup.sh
./setup.sh
```

> 기존 `~/.claude/`가 있으면 백업 후 덮어씁니다. (`~/.claude.backup.YYYYMMDDHHMMSS`)

### Step 4: 프로젝트에서 사용

```bash
cd /path/to/your/project
claude
> /init
> /setup-project
```

> `/init`을 먼저 실행하여 프로젝트 분석 후 `/setup-project`로 글로벌 설정과 지식 시스템을 추가합니다.

---

## Repository Structure

```
claude-code-setup/
├── README.md
├── setup.sh
├── config.yaml
└── templates/
    ├── INDEX.md
    ├── project-structure.md
    ├── optimization-findings.md
    ├── command-registry.md
    ├── paper-references.md
    ├── error-solutions.md
    ├── tech-decisions.md
    └── setup-project.md
```

---

## Configuration Options

### 주요 설정 항목

| 섹션 | 항목 | 옵션 |
|------|------|------|
| **role** | 역할 | ML/AI Research, Web Development, Backend Systems, etc. |
| **stack** | 기술 스택 | Python, PyTorch, TypeScript, etc. (리스트) |
| **tasks** | 작업 유형 | Code analysis, Bug fixing, Implementation, etc. |
| **optimization** | 최적화 우선순위 | primary/secondary: Memory efficiency, Compute speed, Code readability |
| **language** | 응답 언어 | Default, English, Korean |
| **response_style** | 응답 스타일 | concise, detailed |
| **prompt_correction** | 프롬프트 교정 | off, gradual, strict |
| **modes.detection** | 모드 감지 | off, soft, auto |
| **ambiguous_requests** | 모호한 요청 | A, B, C, D |
| **multiple_approaches** | 여러 방법 | A, B, C |
| **change_handling** | 변경 처리 | affected_files, diff_preview, large_changes |

### Ambiguous Requests

| 옵션 | 동작 |
|------|------|
| A | Refine → Execute immediately |
| B | Ask clarification first |
| C | Show refined interpretation → Execute |
| D | Refine → Present options → Execute after selection |

### Multiple Approaches

| 옵션 | 동작 |
|------|------|
| A | Choose best and execute |
| B | Present 2-3 options → ask for selection |
| C | Recommend 1 + briefly mention alternatives |

---

## Generated Structure

```
~/.claude/
├── CLAUDE.md              ← 글로벌 설정 (Claude가 읽음)
├── commands/
│   └── setup-project.md   ← /setup-project 명령어
└── templates/
    └── (7 knowledge templates)
```

프로젝트에서 `/setup-project` 실행 후:

```
your-project/.claude/
├── CLAUDE.md              ← 프로젝트 설정 (글로벌 + 로컬 병합)
├── knowledge/
│   ├── INDEX.md
│   ├── project-structure.md
│   ├── optimization-findings.md
│   ├── command-registry.md
│   ├── paper-references.md
│   ├── error-solutions.md
│   ├── tech-decisions.md
│   └── papers/
└── commands/
```

---

## Knowledge Management

| 상태 | 동작 |
|------|------|
| < 50 entries | 정상 운영 |
| 50+ entries | 정리 제안 (중복/고아 항목 제거) |
| 100+ entries | 압축 제안 (요약 + 최근 20개 + 아카이브) |

---

## Tips

1. **Global Setup**: `./setup.sh`는 컴퓨터당 1회 (설정 변경 시 재실행)
2. **Project Setup**: 새 프로젝트마다 `/setup-project` 실행
3. **백업**: 재실행 시 기존 설정은 `~/.claude.backup.*`에 자동 백업
4. **백업 정리**: 5개 초과 시 경고 표시, 수동 삭제 필요

---

## License

MIT
