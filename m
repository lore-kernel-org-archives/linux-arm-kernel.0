From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 20 May 2014 13:02:32 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAwNS8yMF0gQVJNOiBpbXg1OiByZW1vdmUgaS5NWDUgbm9u?=
 =?UTF-8?B?LURUIGRldmljZSByZWdpc3RyYXRpb24gaGVscGVycw==?=
In-Reply-To: <1400575538-21136-6-git-send-email-shawn.guo@freescale.com>
References: <1400575538-21136-1-git-send-email-shawn.guo@freescale.com>
 <1400575538-21136-6-git-send-email-shawn.guo@freescale.com>
Message-ID: <1400576552.352489173@f117.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tue, 20 May 2014 16:45:23 +0800 ?? Shawn Guo <shawn.guo@freescale.com>:
> i.MX5 is DT only platforms, so these non-DT device registration helpers
> is used nowhere.  Remove them.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-imx/devices/platform-fec.c           | 12 ----------
>  arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c  |  5 ----
>  arch/arm/mach-imx/devices/platform-imx-i2c.c       | 26 ---------------------
>  arch/arm/mach-imx/devices/platform-imx-keypad.c    | 10 --------
>  arch/arm/mach-imx/devices/platform-imx-ssi.c       | 20 ----------------
>  arch/arm/mach-imx/devices/platform-imx-uart.c      | 22 ------------------
>  arch/arm/mach-imx/devices/platform-imx2-wdt.c      | 18 ---------------
>  arch/arm/mach-imx/devices/platform-mxc-ehci.c      |  9 --------
>  arch/arm/mach-imx/devices/platform-mxc_nand.c      |  5 ----
>  arch/arm/mach-imx/devices/platform-pata_imx.c      | 10 --------
>  .../mach-imx/devices/platform-sdhci-esdhc-imx.c    | 24 -------------------
>  arch/arm/mach-imx/devices/platform-spi_imx.c       | 27 ----------------------

Seems, as an follow patch we should also remove SOC_IMX5* symbol
dependencies from arch/arm/mach-imx/devices/Kconfig.

---
