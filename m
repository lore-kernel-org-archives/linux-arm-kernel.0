From: eric@anholt.net (Eric Anholt)
Date: Wed, 14 Sep 2016 10:41:43 +0100
Subject: [PATCH V5 2/6] thermal: bcm2835: add thermal driver for bcm2835
 soc
In-Reply-To: <1473759262-27031-3-git-send-email-kernel@martin.sperl.org>
References: <1473759262-27031-1-git-send-email-kernel@martin.sperl.org>
 <1473759262-27031-3-git-send-email-kernel@martin.sperl.org>
Message-ID: <87lgyurf6w.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Add basic thermal driver for bcm2835 SOC.
>
> This driver currently relies on the firmware setting up the
> tsense HW block and does not set it up itself.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>
> ChangeLog:
>  V1 -> V2: added specific settings depending on compatiblity
> 	   added trip point based on register
> 	   setting up ctrl-register if HW is not enabled by firmware
> 	     as per recommendation of Eric (untested)
> 	   check that clock frequency is in range
> 	     (1.9 - 5MHz - as per comment in clk-bcm2835.c)
>  V2 -> V4: moved back to thermal (not using bcm sub-directory)
>        	   set polling interval to 1second (was 0ms, so interrupt driven)

This is still:

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160914/703cb871/attachment.sig>
