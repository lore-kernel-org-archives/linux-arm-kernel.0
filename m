From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 31 Oct 2013 12:28:02 +0100
Subject: [PATCH] ARM: kirkwood: Cleanup comments in Sheevaplug dts files
In-Reply-To: <1383218367-4012-1-git-send-email-gmbnomis@gmail.com>
References: <1383218367-4012-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <20131031112802.GA23162@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 12:19:27PM +0100, Simon Baatz wrote:
> 
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>

Hi Simon

There should really be some comment in the change log body, even if it
is the subject line said in a different way.

You can add my

Acked-by: Andrew Lunn <andrew@lunn.ch>

on a v2 with an added comment.

   Andrew

> ---
> Hi,
> 
> just two fixes for silly copy and paste errors.
> 
> - Simon
> 
>  arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi |    2 +-
>  arch/arm/boot/dts/kirkwood-sheevaplug.dts         |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi b/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
> index 5696b63..c2bedb6 100644
> --- a/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
> @@ -1,5 +1,5 @@
>  /*
> - * kirkwood-sheevaplug-common.dts - Common parts for Sheevaplugs
> + * kirkwood-sheevaplug-common.dtsi - Common parts for Sheevaplugs
>   *
>   * Copyright (C) 2013 Simon Baatz <gmbnomis@gmail.com>
>   *
> diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug.dts b/arch/arm/boot/dts/kirkwood-sheevaplug.dts
> index bb61918..0de8278 100644
> --- a/arch/arm/boot/dts/kirkwood-sheevaplug.dts
> +++ b/arch/arm/boot/dts/kirkwood-sheevaplug.dts
> @@ -1,5 +1,5 @@
>  /*
> - * kirkwood-sheevaplug-esata.dts - Device tree file for Sheevaplug
> + * kirkwood-sheevaplug.dts - Device tree file for Sheevaplug
>   *
>   * Copyright (C) 2013 Simon Baatz <gmbnomis@gmail.com>
>   *
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
