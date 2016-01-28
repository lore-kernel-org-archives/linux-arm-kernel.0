From: eric@anholt.net (Eric Anholt)
Date: Thu, 28 Jan 2016 14:16:37 -0800
Subject: [PATCH V2 2/3] ARM: bcm2835: I2S: use new register-range and
 clock framework
In-Reply-To: <1452602149-5875-3-git-send-email-kernel@martin.sperl.org>
References: <1452602149-5875-1-git-send-email-kernel@martin.sperl.org>
 <1452602149-5875-3-git-send-email-kernel@martin.sperl.org>
Message-ID: <87powlfiyi.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Since the move to the new clock framework with commit 94cb7f76caa0
> ("ARM: bcm2835: Switch to using the new clock driver support.")
> the bcm2835-i2s driver was no longer working.
>
> This patch fixes the address ranges:
> * remove the PCM clock register range that is owned by the clockmanager
> * fix the length, which did not include the last register of this device
>
> It also adds the required pcm-clock.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160128/1aeb2fdd/attachment.sig>
