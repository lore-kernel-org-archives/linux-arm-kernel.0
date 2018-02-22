From: eric@anholt.net (Eric Anholt)
Date: Thu, 22 Feb 2018 12:11:55 -0800
Subject: [PATCH V3 2/2 RESEND] ARM: dts: bcm283x: Fix probing of
 bcm2835-i2s
In-Reply-To: <1518778534-3328-3-git-send-email-stefan.wahren@i2se.com>
References: <1518778534-3328-1-git-send-email-stefan.wahren@i2se.com>
 <1518778534-3328-3-git-send-email-stefan.wahren@i2se.com>
Message-ID: <871shcaino.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Since 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
> the bcm2835-i2s requires a clock as DT property. Unfortunately
> the necessary DT change has never been applied. While we are at it
> also fix the first PCM register range to cover the PCM_GRAY register.
>
> Fixes: 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Reviewed-by: Eric Anholt <eric@anholt.net>
> Tested-by: Matthias Reichl <hias@horus.com>

I've applied these 2 to bcm2835-dt-next.  Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180222/8929bc37/attachment.sig>
