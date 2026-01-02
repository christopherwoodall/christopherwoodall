---
layout: post
title: "Browser Agent"
date: 2026-01-02
tags: [ "agents", "browser" ]
---

Anthropic recently released [Claude in Chrome](https://support.claude.com/en/articles/12012173-getting-started-with-claude-in-chrome) and as a Firefox user I was a bit jealous. But hey we turn those feelings into action around here, so we put Claude to work writing [a simple browser agent](https://gist.github.com/christopherwoodall/ce8f1cbcbeba4489d7aed41c3144770e) that works in Firefox.

#### [Download it here](https://gist.github.com/christopherwoodall/ce8f1cbcbeba4489d7aed41c3144770e)

---


## Setup

**WARNING:** This isn't safe or production ready. Just a demonstration. Use at your own risk.

1. Install [Tampermonkey](https://www.tampermonkey.net/) or a similar userscript manager.

2. Create a new userscript and copy the code from [this gist](<https://gist.github.com/christopherwoodall/ce8f1cbcbeba4489d7aed41c3144770e).

![Browser Agent Tampermonkey](/assets/notes/agents/2026-01-02-browser-agent/2026-01-02-browser-agent-tampermonkey.png)

3. Click the robot emoji(🤖) in the bottom right corner of any webpage to activate the agent.

![Browser Agent Icon](/assets/notes/agents/2026-01-02-browser-agent/2026-01-02-browser-agent-icon.gif)

4. Click the "Settings" button to configure your API key and model.

![Browser Agent Setup](/assets/notes/agents/2026-01-02-browser-agent/2026-01-02-browser-agent-setup.png)

5. Head over to the "Chat" tab and enter a message to get started!

---


## Review

The model and prompt **really** make a difference here.

![Browser Agent Screenshot](/assets/notes/agents/2026-01-02-browser-agent/2026-01-02-browser-agent.webm)

The agent runs a simple ReACT loop allowing it to operate in cycles. It can call tools(like executing javascript) if the messages are formatted correctly.

![Agent ReACT Loop](/assets/notes/agents/2026-01-02-browser-agent/2026-01-02-browser-agent-react-loop.png)

We instruct the agent on the format for tool use in the system prompt, but it is up to the model to follow it. We can see here how strict the extraction logic is.

![Agent Tool Use](/assets/notes/agents/2026-01-02-browser-agent/2026-01-02-browser-agent-tool-use.png)

Dispite all of that the agents still manages to do pretty well at some tasks - like finding posts or clicking on links. Though have no issues hallucinating or making mistakes.

![Agent Success](/assets/notes/agents/2026-01-02-browser-agent/2026-01-02-browser-agent-success.webm)

---


## Unofficial Benchmark

A lot of this really does come down to good prompt engineering and model selection. Going from a just a few releases ago to something newer was a big step up in capability and reliability.

For the sake of sciene I decided to ask a few models to reimagine my blog as if they were drunk. Below are the results.

#### OpenAI GPT-5.2
![OpenAI GPT-5.2 Intoxicated Bench](/assets/notes/agents/2026-01-02-browser-agent/2026-01-02-openai-gpt-5.2-intoxicated-bench.webm)

#### Anthropic Claude Opus 4.5
![Claude Opus 4.5 Intoxicated Bench](/assets/notes/agents/2026-01-02-browser-agent/2026-01-02-claude-opus-4.5-intoxicated-bench.gif)

#### Google Gemini 3 Pro
![Gemini 3 Pro Intoxicated Bench](/assets/notes/agents/2026-01-02-browser-agent/2026-01-02-gemini-3-pro-intoxicated-bench.gif)

#### Anthropic Grok 4.1 Fast
![Grok 4.1 Fast Intoxicated Bench](/assets/notes/agents/2026-01-02-browser-agent/2026-01-02-grok-4.1-fast-intoxicated-bench.gif)

#### DeepSeek DeepSeek V3.2
![DeepSeek V3.2 Intoxicated Bench](/assets/notes/agents/2026-01-02-browser-agent/2026-01-02-deepseek-v3.2-intoxicated-bench.gif)
