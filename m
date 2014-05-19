From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 19 May 2014 12:06:12 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAzLzRdIEFSTTogaW14OiByZW1vdmUgaW14NTEgbm9uLURU?=
 =?UTF-8?B?IHN1cHBvcnQgZmlsZXM=?=
In-Reply-To: <1400482606-8278-4-git-send-email-shawn.guo@freescale.com>
References: <1400482606-8278-1-git-send-email-shawn.guo@freescale.com>
 <1400482606-8278-4-git-send-email-shawn.guo@freescale.com>
Message-ID: <1400486772.124660835@f325.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mon, 19 May 2014 14:56:45 +0800 ?? Shawn Guo <shawn.guo@freescale.com>:
> Since i.MX51 becomes a DT only platform, those non-DT support files can
> be removed now.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-imx/Makefile        |   2 +-
>  arch/arm/mach-imx/devices-imx51.h |  66 ---
>  arch/arm/mach-imx/ehci-imx5.c     | 171 --------
>  arch/arm/mach-imx/iomux-mx51.h    | 827 --------------------------------------
>  4 files changed, 1 insertion(+), 1065 deletions(-)
>  delete mode 100644 arch/arm/mach-imx/devices-imx51.h
>  delete mode 100644 arch/arm/mach-imx/ehci-imx5.c
>  delete mode 100644 arch/arm/mach-imx/iomux-mx51.h

...

> -int mx51_initialize_usb_hw(int port, unsigned int flags)

Additionally, we should not forget to remove mx51_initialize_usb_hw() declaration
from include/linux/platform_data/usb-ehci-mxc.h in the future.

---
