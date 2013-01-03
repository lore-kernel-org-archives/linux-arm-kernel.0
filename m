From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 3 Jan 2013 22:05:41 +0100
Subject: [PATCH] ARM: tegra: add kexec support to defconfig
In-Reply-To: <1357161141-26430-1-git-send-email-swarren@wwwdotorg.org>
References: <1357161141-26430-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130103210541.GB4412@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 02, 2013 at 02:12:21PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/configs/tegra_defconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
> index 742dc41..e621603 100644
> --- a/arch/arm/configs/tegra_defconfig
> +++ b/arch/arm/configs/tegra_defconfig
> @@ -34,6 +34,7 @@ CONFIG_AEABI=y
>  CONFIG_HIGHMEM=y
>  CONFIG_ZBOOT_ROM_TEXT=0x0
>  CONFIG_ZBOOT_ROM_BSS=0x0
> +CONFIG_KEXEC=y
>  CONFIG_CPU_FREQ=y
>  CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
>  CONFIG_CPU_IDLE=y

Interesting. What do you plan to use this for? kdump?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130103/e0a702be/attachment.sig>
