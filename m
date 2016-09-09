From: eric@anholt.net (Eric Anholt)
Date: Fri, 09 Sep 2016 10:57:24 -0700
Subject: [PATCH V4 2/4] thermal: bcm2835: add thermal driver for bcm2835
 soc
In-Reply-To: <1473407397-29395-3-git-send-email-kernel@martin.sperl.org>
References: <1473407397-29395-1-git-send-email-kernel@martin.sperl.org>
 <1473407397-29395-3-git-send-email-kernel@martin.sperl.org>
Message-ID: <87a8fharcr.fsf@eliezer.anholt.net>
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

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160909/324bf9f8/attachment.sig>
