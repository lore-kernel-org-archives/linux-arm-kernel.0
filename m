From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Sep 2014 15:25:27 +0200
Subject: [PATCH v2 1/7] ARM: sunxi: Introduce Allwinner A80 support
In-Reply-To: <1411570141-29960-2-git-send-email-wens@csie.org>
References: <1411570141-29960-1-git-send-email-wens@csie.org>
 <1411570141-29960-2-git-send-email-wens@csie.org>
Message-ID: <20140925132527.GF15315@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 10:48:55PM +0800, Chen-Yu Tsai wrote:
> The Allwinner A80 is a new Cortex octo-core A7/A15 big.LITTLE SoC.
> While it's processor cores and interconnecting bus are new, it
> re-uses many peripherals found in earlier Allwinner SoCs.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/mach-sunxi/Kconfig | 5 +++++
>  arch/arm/mach-sunxi/sunxi.c | 9 +++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index 1aaa1e1..72f222b 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -42,4 +42,9 @@ config MACH_SUN8I
>  	select MFD_SUN6I_PRCM
>  	select RESET_CONTROLLER
>  
> +config MACH_SUN9I
> +	bool "Allwinner A80 (sun9i) SoCs support"

With the new naming scheme, I wonder wether it makes sense to have the
A80 displayed here and in the machine definition.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140925/5ce42236/attachment-0001.sig>
