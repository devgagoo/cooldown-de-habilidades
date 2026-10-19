# Cooldown de Habilidades (Z, X, C)

Sistema de cooldown de habilidades: o jogador aperta a tecla, o **servidor** decide se a habilidade
pode ser usada e o **cliente** mostra a contagem na interface.

## Onde cada arquivo vai no Roblox

| Arquivo | Lugar no Roblox | Tipo |
|---|---|---|
| `Tecla.server.luau` | `ServerScriptService` | Script |
| `DetectorTecla.client.luau` | `StarterPlayer/StarterPlayerScripts` | LocalScript |
| `DebounceHandler.luau` | `ReplicatedStorage/Libs` | ModuleScript |

## Como funciona

1. **Cliente** (`DetectorTecla.client.luau`): escuta `InputBegan`, ignora o que o jogo já
   processou (com o chat aberto a tecla não vale) e manda a tecla para o servidor.
2. **Servidor** (`Tecla.server.luau`): confere a tecla na tabela de cooldowns (Z = 15s, X = 10s,
   C = 60s). Se a chave `UserId .. tecla` estiver travada, ignora. Se estiver livre, trava pelo
   tempo da habilidade e avisa o cliente.
3. **Cliente de volta**: recebe o cooldown e anima a barra (`Sweep`) com um Tween linear, contando
   os segundos no `Numero` enquanto o símbolo fica escondido.

Quem decide é sempre o servidor — o cliente só desenha. Assim ninguém burla o cooldown mudando o
script local.

**DebounceHandler** é o relógio: `Add(chave, tempo)`, `Check(chave)`, `Remove(chave)` e
`WaitFor(chave)`, tudo em cima do `time()`.

## O que precisa existir no lugar (não são arquivos)

- `ReplicatedStorage/Remotes` com dois **RemoteEvents**: `DetectorTecla` e `Cooldown`.
- `StarterGui/HabilidadesGui/Barra` com um slot por habilidade: `SlotZ`, `SlotX`, `SlotC`.
  Cada slot tem `Numero`, `Simbolo` e `Sweep`.
