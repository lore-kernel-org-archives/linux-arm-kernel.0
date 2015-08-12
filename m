From: Haibo.Chen@freescale.com (Chen Bough)
Date: Wed, 12 Aug 2015 07:26:21 +0000
Subject: [PATCH v2 0/5] Add imx6ul touch screen controller support
In-Reply-To: <1438077521-12857-1-git-send-email-haibo.chen@freescale.com>
References: <1438077521-12857-1-git-send-email-haibo.chen@freescale.com>
Message-ID: <BY1PR03MB13883A9E89CE57A8A1CE02A19A7E0@BY1PR03MB1388.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi all,

Any suggestion about these patch set? Since half month passed without any response.



> -----Original Message-----
> From: Haibo Chen [mailto:haibo.chen at freescale.com]
> Sent: Tuesday, July 28, 2015 5:59 PM
> To: robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; shawnguo at kernel.org;
> kernel at pengutronix.de; linux at arm.linux.org.uk; dmitry.torokhov at gmail.com
> Cc: Chen Haibo-B51421; hans.verkuil at cisco.com; hadess at hadess.net;
> mchehab at osg.samsung.com; mamlinav at gmail.com; arnd at arndb.de;
> jonathar at broadcom.com; hdegoede at redhat.com; christian.gmeiner at gmail.com;
> scott.liu at emc.com.tw; geert at linux-m68k.org; benjamin.tissoires at redhat.com;
> sebastien.szymanski at armadeus.com; sbranden at broadcom.com;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-input at vger.kernel.org
> Subject: [PATCH v2 0/5] Add imx6ul touch screen controller support
> 
> i.MX6UL contains a touch screen controller. This patch set add imx6ul
> touch screen controller driver support.
> 
> Changes for v2:
> -Add property in devicetree Documentation.
> -Add tsc disable code in tsc_remove function.
> -Remove some redundant code.
> 
> 
> Haibo Chen (5):
>   input: touchscreen: add imx6ul_tsc driver support
>   Documentation: Detail permitted DT properties for the imx6ul_tsc
>   ARM: imx_v6_v7_defconfig: enable imx6ul_tsc
>   ARM: dts: imx6ul.dtsi: add TSC support
>   ARM: dts: imx6ul-14x14-evk.dts: add tsc support
> 
>  .../bindings/input/touchscreen/imx6ul_tsc.txt      |  36 ++
>  arch/arm/boot/dts/imx6ul-14x14-evk.dts             |  18 +
>  arch/arm/boot/dts/imx6ul.dtsi                      |  11 +
>  arch/arm/configs/imx_v6_v7_defconfig               |   1 +
>  drivers/input/touchscreen/Kconfig                  |  12 +
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/imx6ul_tsc.c             | 504
> +++++++++++++++++++++
>  7 files changed, 583 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
>  create mode 100644 drivers/input/touchscreen/imx6ul_tsc.c
> 
> --
> 1.9.1
