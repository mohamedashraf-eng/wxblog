---
title: Integrate LLM with your daily software developing
layout: page
---  

Hello! I'm Mohamed Ashraf, and today I'll show you how to leverage LLMs (Large Language Models) to supercharge your daily software development. Let's dive in!

---

## Starting

### What is an LLM?

**Definition:**
LLM stands for Large Language Model. These AI models are trained on vast amounts of text data to understand and generate human-like language. Using deep learning techniques and neural networks, LLMs perform a wide range of natural language processing (NLP) tasks, such as text completion, translation, summarization, and more.

### History

1. **Early Beginnings:**
   - In the 1950s, simple statistical methods for language processing were developed.
   - Early NLP efforts involved rule-based systems and basic probabilistic models like n-grams, predicting words based on a fixed number of preceding words.

2. **Neural Networks and Word Embeddings (1990s - 2010s):**
   - The 1990s saw the rise of neural networks for language modeling.
   - Word embeddings like Word2Vec and GloVe emerged in the early 2010s, representing words as vectors, capturing semantic relationships.

3. **The Rise of Deep Learning (2014 - 2017):**
   - Recurrent Neural Networks (RNNs), especially Long Short-Term Memory (LSTM) networks, improved sequential data handling.
   - The Transformer architecture, introduced by Vaswani et al. in 2017, revolutionized NLP by processing entire sentences simultaneously.

4. **Large Language Models and Transfer Learning (2018 - Present):**
   - OpenAI's GPT set a new standard for LLMs in 2018. GPT-2 and GPT-3 followed, each larger and more capable.
   - These models demonstrated the power of pre-training on vast datasets and fine-tuning on specific tasks, known as transfer learning.
   - Other notable LLMs include Google’s BERT, T5, and more recently, GPT-4.

### Usage of LLMs

1. **Text Generation and Completion:** For creative writing, drafting emails, and generating code.
2. **Translation and Summarization:** Translating text between languages and summarizing documents.
3. **Chatbots and Virtual Assistants:** Powering conversational agents for customer support and task assistance.
4. **Content Creation and Editing:** Assisting in writing, creating marketing content, and editing text.
5. **Research and Information Retrieval:** Generating literature reviews, extracting information, and answering complex questions.
6. **Education and Training:** Providing personalized tutoring, generating educational materials, and aiding language learning.

### Latest Developments

1. **GPT-4 and Beyond:** Enhanced performance in language understanding and generation.
2. **Multimodal Models:** Combining text with other data types, like images (e.g., CLIP by OpenAI).
3. **Ethical AI and Bias Mitigation:** Reducing biases and making models more ethical and fair.
4. **Real-time and Low-latency Models:** Deploying LLMs in real-time applications with reduced latency.
5. **Specialized LLMs:** Fine-tuning models for specific industries, such as legal (e.g., CaseText) and medical (e.g., PubMedBERT).

---

## Getting Started

Let's make use of these amazing LLM features to automate some of our tasks.

### Minimum Requirements

- Apple/Nvidia GPU with 4GB+ VRAM. If the GPU is incompatible, the model will use the CPU (slower).
- 500MB Storage for the program and more for the model.
- OS: Linux, Mac, Windows (Beta).

### Downloading

1. Download the [Ollama](https://ollama.com/download) program based on your OS.
2. Pick a model from the [Ollama library](https://ollama.com/library).  
   Ensure the model’s VRAM requirement matches your GPU’s VRAM to avoid [performance issues](https://ollama.com/library).

<div style="text-align:center;">
   <a href="https://ibb.co/2KdQ1q7"><img src="https://i.ibb.co/RHcmk2p/post-gpucpussd-bottleneck.png" alt="post-gpucpussd-bottleneck" border="0" /></a>
</div>

> **Tip:** Focus on a model that meets your needs rather than one that tries to do everything.

**Recommended Models:**  

- `starcoder2:3b` (for 4GB VRAM)
- `codellama:7b` (for 8GB VRAM)

To download the model, run:  

```bash
ollama pull <model_name>
```

To start the model, run:  

```bash
ollama run <model_name>
```

## Usage

1. Download the [Continue](https://docs.continue.dev/quickstart) extension for VSCode.
2. Ensure your `.continue/config.json` includes the model you downloaded.  

```bash
"models": [
  {
    "title": "Ollama",
    "provider": "ollama",
    "model": "<model_name>"
  }
]
```  

After restarting VSCode, the extension will reload, parse your files, and start your LLM.  

<div style="text-align:center;">
   <a href="https://imgbb.com/"><img src="https://i.ibb.co/8N2tLcg/post-continue-indexing.png" alt="post-continue-indexing" border="0" /></a>
</div>

You can now write directly to your model  

<div style="text-align:center;">
   <a href="https://imgbb.com/"><img src="https://i.ibb.co/rkLPb6X/ollama-gen.gif" alt="ollama-gen" border="0" /></a>
</div>


Or let the model help you with autocompletion.  

<div style="text-align:center;">
   <a href="https://ibb.co/jyvFhQS"><img src="https://i.ibb.co/QPFG9T4/ollama-complete.gif" alt="ollama-complete" border="0" /></a>
</div>

You can also highlight code and press `Ctrl+Shift+I` to interact with the model.  

Thanks for reading! Enjoy integrating LLMs into your daily development workflow! 🚀  

`(c) 2024, MoWx-04-06`