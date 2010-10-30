From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 30 Oct 2010 09:51:04 +0200
Subject: [patch v4 05/10] imx51: add gpio mode for csi1 {h,v}sync
In-Reply-To: <20101027124345.755584279@rtp-net.org>
References: <20101027124044.980739780@rtp-net.org>
	<20101027124345.755584279@rtp-net.org>
Message-ID: <201010300951.04885.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 October 2010 14:40:50 Arnaud Patard wrote:
> Add definitions for configuring CSI1_{H,V}SYNC as GPIO
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Index: linux-2.6-submit/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> ===================================================================
> ---
> linux-2.6-submit.orig/arch/arm/plat-mxc/include/mach/iomux-mx51.h	2010-10-
> 20 18:30:44.000000000 +0200 +++
> linux-2.6-submit/arch/arm/plat-mxc/include/mach/iomux-mx51.h	2010-10-20
> 18:30:48.000000000 +0200 @@ -200,7 +200,9 @@
>  #define MX51_PAD_CSI1_D18__CSI1_D18             IOMUX_PAD(0x5A4, 0x1BC, 0,
> 0x0,   0, NO_PAD_CTRL) #define MX51_PAD_CSI1_D19__CSI1_D19            
> IOMUX_PAD(0x5A8, 0x1C0, 0, 0x0,   0, NO_PAD_CTRL) #define
> MX51_PAD_CSI1_VSYNC__CSI1_VSYNC         IOMUX_PAD(0x5AC, 0x1C4, 0, 0x0,  
> 0, NO_PAD_CTRL) +#define MX51_PAD_CSI1_VSYNC__GPIO_3_14         
> IOMUX_PAD(0x5AC, 0x1C4, 3, 0x0,   0, MX51_GPIO_PAD_CTRL) #define
> MX51_PAD_CSI1_HSYNC__CSI1_HSYNC         IOMUX_PAD(0x5B0, 0x1C8, 0, 0x0,  
> 0, NO_PAD_CTRL) +#define MX51_PAD_CSI1_HSYNC__GPIO_3_15         
> IOMUX_PAD(0x5B0, 0x1C8, 3, 0x0,   0, MX51_GPIO_PAD_CTRL) #define
> MX51_PAD_CSI1_PIXCLK__CSI1_PIXCLK       IOMUX_PAD(0x5B4, 0x000, 0, 0x0,  
> 0, NO_PAD_CTRL) #define MX51_PAD_CSI1_MCLK__CSI1_MCLK          
> IOMUX_PAD(0x5B8, 0x000, 0, 0x0,   0, NO_PAD_CTRL) #define
> MX51_PAD_CSI1_PKE0__CSI1_PKE0           IOMUX_PAD(0x860, 0x000, 0, 0x0,  
> 0, NO_PAD_CTRL)
> 
> 

DTTO for 03/10 ... CC the freescale people here
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
