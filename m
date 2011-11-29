From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 29 Nov 2011 20:23:43 +0100
Subject: [PATCH] ARM: mxs: Select FEC driver
In-Reply-To: <1322592607-22834-1-git-send-email-fabio.estevam@freescale.com>
References: <1322592607-22834-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <201111292023.43770.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Let the FEC driver be built by default.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/configs/mxs_defconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/mxs_defconfig
> b/arch/arm/configs/mxs_defconfig index 6ee781b..f99bcfc 100644
> --- a/arch/arm/configs/mxs_defconfig
> +++ b/arch/arm/configs/mxs_defconfig
> @@ -59,6 +59,8 @@ CONFIG_DEVTMPFS=y
>  # CONFIG_BLK_DEV is not set
>  CONFIG_NETDEVICES=y
>  CONFIG_NET_ETHERNET=y
> +CONFIG_NET_VENDOR_FREESCALE=y
> +CONFIG_FEC=y
>  CONFIG_ENC28J60=y
>  # CONFIG_NETDEV_1000 is not set
>  # CONFIG_NETDEV_10000 is not set

Acked-by: Marek Vasut <marek.vasut@gmail.com>
