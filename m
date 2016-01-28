From: eric@anholt.net (Eric Anholt)
Date: Thu, 28 Jan 2016 11:53:00 -0800
Subject: [PATCH V2 1/8] dmaengine: bcm2835: set residue_granularity field
In-Reply-To: <1452187987-2605-2-git-send-email-kernel@martin.sperl.org>
References: <1452187987-2605-1-git-send-email-kernel@martin.sperl.org>
 <1452187987-2605-2-git-send-email-kernel@martin.sperl.org>
Message-ID: <8760ydlbvn.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> bcm2835-dma supports residue reporting at burst level but didn't report
> this via the residue_granularity field.
>
> See also:
> https://github.com/raspberrypi/linux/commit/b015555327afa402f70ddc86e3632f59df1cd9d7
> for the downstream patch.
>
> Signed-off-by: Matthias Reichl <hias@horus.com>
> Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160128/05eaaaa4/attachment.sig>
