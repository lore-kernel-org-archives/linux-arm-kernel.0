From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 10 Nov 2011 16:49:18 +0800
Subject: [PATCH 1/4] arm/imx: fix mx3_defconfig to add FEC back
In-Reply-To: <1320914372-4416-2-git-send-email-shawn.guo@linaro.org>
References: <1320914372-4416-1-git-send-email-shawn.guo@linaro.org>
 <1320914372-4416-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111110084917.GB14617@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Is it supposed to be generated, like by make menuconfig?

Richard
On Thu, Nov 10, 2011 at 04:39:29PM +0800, Shawn Guo wrote:
> The commit 'd880db0 arm: mx3: update defconfig' removes FEC support
> which is not good, since FEC is useful for both developers and users.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/configs/mx3_defconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/mx3_defconfig b/arch/arm/configs/mx3_defconfig
> index cb0717f..ee50a9e 100644
> --- a/arch/arm/configs/mx3_defconfig
> +++ b/arch/arm/configs/mx3_defconfig
> @@ -67,6 +67,7 @@ CONFIG_SMSC_PHY=y
>  CONFIG_NET_ETHERNET=y
>  CONFIG_SMSC911X=y
>  CONFIG_DNET=y
> +CONFIG_FEC=y
>  # CONFIG_NETDEV_1000 is not set
>  # CONFIG_NETDEV_10000 is not set
>  # CONFIG_INPUT_MOUSEDEV is not set
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
