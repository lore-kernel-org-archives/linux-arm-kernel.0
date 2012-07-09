From: marex@denx.de (Marek Vasut)
Date: Mon, 9 Jul 2012 09:04:52 +0200
Subject: [PATCH 0/7] Convert mxs board files to device tree
In-Reply-To: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <201207090904.52805.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> With imx23-evk and imx28-evk converted to device tree, it's time to
> start looking at other mxs boards.
> 
> Marek, Lauri and Lothar,
> 
> Please do me the favor to test the series on your boards to see if it
> provides the same functionality as the board file.  You can just use
> the branch below.

I can send you updated file, but it contains some additional cruft -- especially 
the SPI and i2c stuff. But then, I guess it just won't be probed, right ?

>   git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/dt/others
> 
> Thanks,
> Shawn
> 
> Marek Vasut (1):
>   ARM: mxs: convert m28evk board to device tree
> 
> Shawn Guo (6):
>   ARM: dts: imx28: move extra gpmi-nand pins into board dts
>   ARM: dts: imx28: move lcdif control pins into board dts
>   ARM: mxs: convert apx4devkit board to device tree
>   ARM: mxs: convert tx28 board to device tree
>   ARM: mxs: convert stmp378x_devb board to device tree
>   ARM: mxs: add dtb-y target into Makefile.boot
> 
>  arch/arm/boot/dts/apx4devkit.dts    |  143 +++++++++++++++++++++
>  arch/arm/boot/dts/imx28-evk.dts     |   30 ++++-
>  arch/arm/boot/dts/imx28.dtsi        |   96 +++++++++++++-
>  arch/arm/boot/dts/m28evk.dts        |  241
> +++++++++++++++++++++++++++++++++++ arch/arm/boot/dts/stmp378x_devb.dts | 
>  78 +++++++++++
>  arch/arm/boot/dts/tx28.dts          |  112 ++++++++++++++++
>  arch/arm/mach-mxs/Makefile.boot     |    9 ++
>  arch/arm/mach-mxs/mach-mxs.c        |  102 +++++++++++++++-
>  8 files changed, 802 insertions(+), 9 deletions(-)
>  create mode 100644 arch/arm/boot/dts/apx4devkit.dts
>  create mode 100644 arch/arm/boot/dts/m28evk.dts
>  create mode 100644 arch/arm/boot/dts/stmp378x_devb.dts
>  create mode 100644 arch/arm/boot/dts/tx28.dts

Best regards,
Marek Vasut
