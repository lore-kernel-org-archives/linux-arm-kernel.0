From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 May 2014 12:38:21 -0700
Subject: [GIT PULL 2nd 2/2] Samsung DT updates for 3.16
In-Reply-To: <033001cf788a$53f79c30$fbe6d490$@samsung.com>
References: <033001cf788a$53f79c30$fbe6d490$@samsung.com>
Message-ID: <20140529193821.GE18481@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 11:29:32AM +0900, Kukjin Kim wrote:
> The following changes since commit b5839bd87f197e133a0025c36df286eab6e1d858:
> 
>   ARM: dts: Add MFC memory banks to exynos5420 boards (2014-05-20 01:04:13
> +0900)
> 
> are available in the git repository at:
> 
>   http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-dt-2
> 
> for you to fetch changes up to 3c8977f17796f0b8816a1a283b0b80b71c83d416:
> 
>   ARM: dts: enable usb nodes for exynos4412-trats2 (2014-05-23 03:31:33
> +0900)
> 
> ----------------------------------------------------------------
> Samsung 2nd DT updates for v3.16
> 
> - exynos4
>   : add hsotg device, exynos_usbphy nodes
>   : add PMU syscon and audio subsystem nodes
>   : replace number by macro in clock binding
> 
> - exynos4210-universal_c210
>  : add external sd card node and multimedia nodes
>  : enable USB functionality
> 
> - exynos4412-trats2
>  : enable usb nodes and usb gagdet functionality
>  : add cm36651 light/proximity sensor node
>  : fixed gpio key node
> 
> - exynos5250 and exynos5420
>   : add pmu syscon handle and sysreg system controller nodes
>   : add support for usb2phy
>   : replace number by macro in clock binding
>   : add USB 2.0 support on exynos5420
> 
> - exynos5420-peach-pit
>   : move dp hpd gpio pin to pinctrl_0

Merged, thanks.


-Olof
