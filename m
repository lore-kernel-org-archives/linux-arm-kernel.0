From: davidsin@ti.com (Sin, David)
Date: Mon, 26 Jul 2010 14:44:51 -0500
Subject: [RFC 0/8] TI TILER-DMM driver
In-Reply-To: <AANLkTinyidvgpE26M=JXjpouoC+mPfehQWyr4L_bQHu_@mail.gmail.com>
References: <1279927694-26138-1-git-send-email-davidsin@ti.com>
	<AANLkTinyidvgpE26M=JXjpouoC+mPfehQWyr4L_bQHu_@mail.gmail.com>
Message-ID: <513FF747EED39B4AADBB4D6C9D9F9F7903D63B9DF7@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your feedback, Linus.  I will incorporate an acronym list in the documentation.  TCM stands for TILER container manager, which pretty much represents the interface to the logic which determines the location for a given 2-D area request.  SiTA (Simple TILER algorithm) is the implementation behind that interface.  I will work on revising the acronym to avoid any conflicts.

-David     

-----Original Message-----
From: Linus Walleij [mailto:linus.ml.walleij at gmail.com] 
Sent: Saturday, July 24, 2010 6:48 PM
To: Sin, David
Cc: linux-arm-kernel at lists.infradead.org
Subject: Re: [RFC 0/8] TI TILER-DMM driver

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
