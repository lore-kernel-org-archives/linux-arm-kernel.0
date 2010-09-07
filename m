From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 7 Sep 2010 20:18:59 +0200
Subject: [PATCH 0/6] ARM: l2x0: kexex, cleanup and optimisation
In-Reply-To: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
References: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <AANLkTi=chtedwbDDJnZOe5yTqobUeXz=aZYUNNUDpQQm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/7 Santosh Shilimkar <santosh.shilimkar@ti.com>:

> This series is just repost adding Catalin's ack to the patches and
> combining Thomas's two rebased kexec patches.
> It's generated against the mainline 2.6.36-rc3 + Catalin's
> "[PATCH 0/9] Various patches for 2.6.37-rc1" series.
>
> Santosh Shilimkar (4):
> ?omap4: l2x0: Override the default l2x0_disable
> ?ARM: l2x0: Fix coding-style in the cache-l2x0.h
> ?ARM: l2x0: Determine the cache size
> ?ARM: l2x0: Optimise the range based operations
>
> Thomas Gleixner (2):
> ?arm: Disable outer (L2) cache in kexec
> ?arm: Implement l2x0 cache disable functions

FWIW:
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Can you also include the patch by Per Fransson I sent off to
Thomas and the list just a few days ago with the subject
"[PATCH] ARM: ux500 specific L2 cache code"
in this patch series?

Yours,
Linus Walleij
