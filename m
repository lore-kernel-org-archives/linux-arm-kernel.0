From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 25 Mar 2011 17:35:30 +0900
Subject: [PATCH 6/6] ARM: Remove clkdev.o build in arch/arm/common/Makefile
In-Reply-To: <1300521019-13612-7-git-send-email-thomas.ab@samsung.com>
References: <1300521019-13612-1-git-send-email-thomas.ab@samsung.com>
	<1300521019-13612-7-git-send-email-thomas.ab@samsung.com>
Message-ID: <000101cbeac7$9df03df0$d9d0b9d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> 
> clkdev.c is moved to drivers/clk. So build for clkdev.o can
> be removed from arch/arm/common/Makefile.
> 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/common/Makefile |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
> index e7521bc..6ea9b6f 100644
> --- a/arch/arm/common/Makefile
> +++ b/arch/arm/common/Makefile
> @@ -16,5 +16,4 @@ obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
>  obj-$(CONFIG_ARCH_IXP2000)	+= uengine.o
>  obj-$(CONFIG_ARCH_IXP23XX)	+= uengine.o
>  obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
> -obj-$(CONFIG_COMMON_CLKDEV)	+= clkdev.o
>  obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
> --
> 1.6.6.rc2

Yeah, right.

But, should be handled in Linux ARM kernel mailing list.
Cc'ed Russell and LAKML :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
