From: eric@anholt.net (Eric Anholt)
Date: Mon, 29 Feb 2016 12:39:18 -0800
Subject: [PATCH 1/2] clk: bcm2835: expose raw clock-registers via debugfs
In-Reply-To: <1456755616-2472-2-git-send-email-kernel@martin.sperl.org>
References: <1456755616-2472-1-git-send-email-kernel@martin.sperl.org>
 <1456755616-2472-2-git-send-email-kernel@martin.sperl.org>
Message-ID: <87k2ln5k09.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> For debugging purposes under some circumstance
> it helps to be able to see the actual clock registers.
>
> E.g: when looking at the clock divider it is helpful to
> see what the actual clock divider is.
>
> This patch exposes all the clock registers specific to each
> clock/pll/pll-divider via debugfs.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

This one definitely seems useful to me.  I think the debugfs bits need
to be under #ifdef CONFIG_DEBUG_FS though.

With that fixed,

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160229/934bd4f7/attachment.sig>
