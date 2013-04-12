From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 12 Apr 2013 13:13:36 +0100
Subject: [PATCH] ASoC: samsung: fix neo1973-wm8753 compilation
In-Reply-To: <201304112102.43896.heiko@sntech.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <201304111908.42532.arnd@arndb.de>
 <20130411171938.GS9243@opensource.wolfsonmicro.com>
 <201304112102.43896.heiko@sntech.de>
Message-ID: <20130412121320.GX9243@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 09:02:43PM +0200, Heiko St?bner wrote:
> Commit b2ca78717cea (ARM: S3C24XX: make gta02.h local) already replaced
> the GTA02_GPIO_* constants in neo1973-wm8753.c but forgot to remove the
> inclusion of mach/gta02.h before moving the file out of mach/.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130412/6758b9e0/attachment.sig>
