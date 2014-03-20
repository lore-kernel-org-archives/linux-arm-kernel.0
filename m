From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 20 Mar 2014 09:19:09 -0400
Subject: [PATCH] ARM: mvebu: Enable NEON support in defconfig
In-Reply-To: <1395268736-13338-1-git-send-email-gregory.clement@free-electrons.com>
References: <1395268736-13338-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <814EB6F5-E322-433A-9FC0-1879AD9B76B2@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On Mar 19, 2014, at 18:38, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
> 
> CONFIG_NEON is no more turning on unconditionally when Armada 375 or
> Armada 38x are selected. However we still want it selected for the
> reference configuration.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> arch/arm/configs/mvebu_v7_defconfig | 1 +
> 1 file changed, 1 insertion(+)

Acked-by: Jason Cooper <jason@lakedaemon.net>

Arnd,

Mind including this with your series of fixes?

thx,

Jason.

> diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
> index 62b6a37626c5..36797dbfa610 100644
> --- a/arch/arm/configs/mvebu_v7_defconfig
> +++ b/arch/arm/configs/mvebu_v7_defconfig
> @@ -26,6 +26,7 @@ CONFIG_ZBOOT_ROM_BSS=0x0
> CONFIG_ARM_APPENDED_DTB=y
> CONFIG_ARM_ATAG_DTB_COMPAT=y
> CONFIG_VFP=y
> +CONFIG_NEON=y
> CONFIG_NET=y
> CONFIG_INET=y
> CONFIG_BT=y
> -- 
> 1.8.1.2
> 
