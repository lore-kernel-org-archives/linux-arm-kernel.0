From: eric@anholt.net (Eric Anholt)
Date: Mon, 29 Feb 2016 12:11:28 -0800
Subject: [PATCH 4/6] clk: bcm2835: divider value has to be 1 or more
In-Reply-To: <1456745963-2403-5-git-send-email-kernel@martin.sperl.org>
References: <1456745963-2403-1-git-send-email-kernel@martin.sperl.org>
 <1456745963-2403-5-git-send-email-kernel@martin.sperl.org>
Message-ID: <87si0b5lan.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Current clamping of a normal divider allows a value < 1 to be valid.
>
> A divider of < 1 would actually only be possible if we had a PLL...
>
> So this patch clamps the divider to 1.
>
> Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the
> audio domain clocks")
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160229/3c909ba8/attachment.sig>
