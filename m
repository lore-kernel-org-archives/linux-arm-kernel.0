From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Apr 2013 14:08:24 +0100
Subject: [PATCH v5 0/6] Initial Device Tree support for S3C64xx
In-Reply-To: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
References: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130417130824.GB13687@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 11:14:37PM +0200, Tomasz Figa wrote:
> This series adds Device Tree support for Samsung S3C64xx SoC series.
> 
> It fixes several problems preventing from booting an S3C64xx-based system
> using Device Tree, adds all the infrastructure for Device Tree-based board
> support, including mach-s3c64xx-dt and dts include files for S3C64xx SoCs,
> and basic device tree source for FriendlyARM Mini6410 board.

Tested-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

in the non-DT case :P
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130417/7ec00e05/attachment.sig>
