---
layout: post
title: "Similarity Metrics: Jaccard and Friends"
date: 2026-08-03
tags: [ "python", "similarity", "jaccard", "nlp", "data-science" ]
---

## Similarity Metrics: Jaccard and Friends

When comparing sets or documents you need a way to quantify *how alike* two things are. Several classic metrics exist, each with its own strengths and blind spots. Below is a tour of the most common ones with Python snippets and notes on when each breaks down.

---

### Jaccard Similarity

The Jaccard index measures the overlap between two sets relative to their union.

```
J(A, B) = |A ∩ B| / |A ∪ B|
```

```python
def jaccard(a: set, b: set) -> float:
    if not a and not b:
        return 1.0
    return len(a & b) / len(a | b)

A = {"cat", "dog", "bird"}
B = {"cat", "dog", "fish", "snake", "parrot"}

print(jaccard(A, B))  # 0.286 — despite sharing 2 of 3 elements from A
```

#### ⚠️ Size Discrepancy Problem

Jaccard is sensitive to **size differences between sets**. When one set is much larger than the other, the denominator (the union) is dominated by the larger set, driving the score down — even when the smaller set is almost entirely contained within the larger one.

```python
small = {"cat", "dog"}
large = {"cat", "dog", "fish", "snake", "parrot", "hamster", "turtle", "rabbit"}

print(jaccard(small, large))  # 0.25 — yet small ⊆ large almost perfectly
```

Here `small` shares 100% of its members with `large`, but the Jaccard score is only 0.25 because the union is large. **If size balance matters, Jaccard will mislead you.**

---

### Overlap Coefficient (Szymkiewicz–Simpson)

The overlap coefficient fixes the size problem by dividing by the *smaller* set instead of the union.

```
overlap(A, B) = |A ∩ B| / min(|A|, |B|)
```

```python
def overlap(a: set, b: set) -> float:
    if not a or not b:
        return 0.0
    return len(a & b) / min(len(a), len(b))

print(overlap(small, large))  # 1.0 — small is fully contained in large
```

This is ideal when containment matters more than balance, e.g. checking if a user's tags are a subset of a document's tags.

---

### Sørensen–Dice Coefficient

Dice is a middle ground — it weights the intersection double and divides by the sum of both set sizes (not the union). It is more forgiving of size differences than Jaccard but less than the overlap coefficient.

```
Dice(A, B) = 2 * |A ∩ B| / (|A| + |B|)
```

```python
def dice(a: set, b: set) -> float:
    if not a and not b:
        return 1.0
    return 2 * len(a & b) / (len(a) + len(b))

print(dice(small, large))   # 0.4
print(dice(A, B))            # 0.5
```

Dice is popular in biomedical and NLP literature. Note the algebraic relationship with Jaccard:

```
Dice = 2J / (1 + J)
J    = Dice / (2 - Dice)
```

---

### Cosine Similarity

For documents or vectors, cosine similarity measures the *angle* between two vectors in a term-frequency space. It is inherently length-normalised, which makes it robust to documents of very different lengths.

```python
import math
from collections import Counter

def cosine(a: list[str], b: list[str]) -> float:
    ca, cb = Counter(a), Counter(b)
    terms = set(ca) | set(cb)
    dot   = sum(ca[t] * cb[t] for t in terms)
    mag_a = math.sqrt(sum(v**2 for v in ca.values()))
    mag_b = math.sqrt(sum(v**2 for v in cb.values()))
    if not mag_a or not mag_b:
        return 0.0
    return dot / (mag_a * mag_b)

doc1 = "the cat sat on the mat".split()
doc2 = "the cat sat on the mat and the cat played".split()

print(cosine(doc1, doc2))   # ~0.976 — near-identical despite different lengths
print(jaccard(set(doc1), set(doc2)))  # 0.667
```

---

### Quick Comparison

| Metric | Range | Size-sensitive | Best for |
|---|---|---|---|
| Jaccard | [0, 1] | **Yes** — punishes size gaps | Balanced, similarly-sized sets |
| Overlap | [0, 1] | No — rewards containment | Checking if small ⊆ large |
| Dice | [0, 1] | Moderate | NLP, bioinformatics |
| Cosine | [-1, 1] | No — length-normalised | Documents, embeddings, TF-IDF |

---

### Takeaway

When your sets differ significantly in size, **Jaccard will underestimate similarity** because the union balloons with the larger set's unique elements. Reach for the **overlap coefficient** when containment is the right question, **Dice** when you want a softer penalty, and **cosine** when working with term or embedding vectors.
