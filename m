From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 25 Jul 2010 01:48:01 +0200
Subject: [RFC 0/8] TI TILER-DMM driver
In-Reply-To: <1279927694-26138-1-git-send-email-davidsin@ti.com>
References: <1279927694-26138-1-git-send-email-davidsin@ti.com>
Message-ID: <AANLkTinyidvgpE26M=JXjpouoC+mPfehQWyr4L_bQHu_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/24 David Sin <davidsin@ti.com>:

> TILER is a hardware block made by Texas Instruments. ?Its purpose is to
> organize video/image memory in a 2-dimensional fashion to limit memory
> bandwidth and facilitate 0 effort rotation and mirroring. ?The TILER
> driver facilitates allocating, freeing, as well as mapping 2D blocks (areas)
> in the TILER container(s). ?It also facilitates rotating and mirroring
> the allocated blocks or its rectangular subsections.

Pretty cool hardware!

(...)
> * Add multiple search directions to TCM-SiTA
> * Add 1D block support (including adding 1D search algo to TCM-SiTA)

Spell out these acronyms. I've been writing some code for the ARM
TCM (Tightly Coupled Memory) and often vendors pick up this terminology
and call all on-chip memory "TCM", though it has a specific technical
meaning in ARM context.

What does TCM mean in your case?
And what is SiTA?

Yours,
Linus Walleij
