From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Mon, 1 Dec 2014 02:38:12 +0000
Subject: [PATCH 0/4] LS1021A: Add dcfb framebuffer driver support.
In-Reply-To: <1416824454-28156-1-git-send-email-Li.Xiubo@freescale.com>
References: <1416824454-28156-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <BY2PR0301MB0613C9A88CF0353C0B41603B9B7D0@BY2PR0301MB0613.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'd like to know the status of this patches for internal release needed.

Thanks very much,

BRs
Xiubo


> -----Original Message-----
> From: Xiubo Li [mailto:Li.Xiubo at freescale.com]
> Sent: Monday, November 24, 2014 6:21 PM
> To: plagnioj at jcrosoft.com; tomi.valkeinen at ti.com
> Cc: shawn.guo at linaro.org; linux-fbdev at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Xiubo Li-B47053
> Subject: [PATCH 0/4] LS1021A: Add dcfb framebuffer driver support.
> 
> Framebuffer driver for the Freescale SoC Display Controller.
> 
> Xiubo Li (4):
>   video: fsl-dcfb: Add dcfb framebuffer driver for LS1021A platform
>   video: fsl-dcfb: Add devicetree binding support
>   ARM: ls1021a: dtsi: Add dt node support for dcfb.
>   ARM: ls1021a: dts: Add and enable dt node for dcfb.
> 
>  .../devicetree/bindings/video/fsl,dcfb.txt         |  52 ++
>  arch/arm/boot/dts/ls1021a-twr.dts                  |  26 +
>  arch/arm/boot/dts/ls1021a.dtsi                     |  10 +
>  drivers/video/fbdev/Kconfig                        |  19 +
>  drivers/video/fbdev/Makefile                       |   1 +
>  drivers/video/fbdev/fsl-dcfb.c                     | 811
> +++++++++++++++++++++
>  6 files changed, 919 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/fsl,dcfb.txt
>  create mode 100644 drivers/video/fbdev/fsl-dcfb.c
> 
> --
> 2.1.0.27.g96db324
