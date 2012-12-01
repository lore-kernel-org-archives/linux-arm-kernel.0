From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 1 Dec 2012 23:05:13 +0900
Subject: [PATCH] ARM: SAMSUNG: Fix build of I2S driver
In-Reply-To: <1d7501cdcee9$ddefbb30$99cf3190$%kim@samsung.com>
References: <1353944420-3972-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <15c501cdcc36$db54cb00$91fe6100$%kim@samsung.com>
 <20121127064313.GV9411@opensource.wolfsonmicro.com>
 <1d7501cdcee9$ddefbb30$99cf3190$%kim@samsung.com>
Message-ID: <20121201140512.GF17981@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 08:00:10PM +0900, Kukjin Kim wrote:

> Mark, I'm holding on Padma's changes for Samsung audio.

> If any updates about this from your side?

> Is it ok to send current next/audio-samsung in my tree to upstream for v3.8?

They didn't seem to have broken anything in -next for me, though I
suspect you'll have bisection breakage for Exynos as the platform data
is being removed separately to the driver update to not look for it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121201/0c628bf3/attachment.sig>
