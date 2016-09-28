From: eric@anholt.net (Eric Anholt)
Date: Wed, 28 Sep 2016 14:10:26 -0700
Subject: [PATCH V7 2/6] thermal: bcm2835: add thermal driver for bcm2835
 soc
In-Reply-To: <1474446227-1147-3-git-send-email-kernel@martin.sperl.org>
References: <1474446227-1147-1-git-send-email-kernel@martin.sperl.org>
 <1474446227-1147-3-git-send-email-kernel@martin.sperl.org>
Message-ID: <87twczg27x.fsf@eliezer.anholt.net>
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
> Acked-by: Eric Anholt <eric@anholt.net>
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

What's the status of merging this one?  I'd like to merge the other
patches.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160928/23e2792a/attachment.sig>
