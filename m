From: broonie@kernel.org (Mark Brown)
Date: Tue, 16 Apr 2013 17:33:32 +0100
Subject: [PATCH v5 0/6] Initial Device Tree support for S3C64xx
In-Reply-To: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
References: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130416163331.GP26958@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 11:14:37PM +0200, Tomasz Figa wrote:
> This series adds Device Tree support for Samsung S3C64xx SoC series.
> 
> It fixes several problems preventing from booting an S3C64xx-based system
> using Device Tree, adds all the infrastructure for Device Tree-based board
> support, including mach-s3c64xx-dt and dts include files for S3C64xx SoCs,
> and basic device tree source for FriendlyARM Mini6410 board.

I tried to test this but the pinctrl driver doesn't build in -next
(drivers/pinctrl/pinctrl-s3c64xx.c:418:9: error: undefined identifier
'chained_irq_enter') - will check properly tomorrow, need to leave now.
But that's separate anyway. :P

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130416/f5621dd8/attachment.sig>
