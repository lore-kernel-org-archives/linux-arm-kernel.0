From: jacopo@jmondi.org (jacopo mondi)
Date: Mon, 9 Jul 2018 16:26:30 +0200
Subject: [PATCH v5 7/7] ARM: dts: rcar-gen2: Remove un-supported VIN
 properties
In-Reply-To: <1531145962-1540-8-git-send-email-jacopo+renesas@jmondi.org>
References: <1531145962-1540-1-git-send-email-jacopo+renesas@jmondi.org>
 <1531145962-1540-8-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <20180709142630.GC23629@w540>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ah ups,
   I initially had this one in the series (see, it's [7/7]), then I
dropped it not to sparkle any more debate, and re-generated patches,
but forget to remove this one, which has been sent with the rest of
the series.

So please ignore it.

Sorry for the noise.
   j

On Mon, Jul 09, 2018 at 04:19:22PM +0200, Jacopo Mondi wrote:
> Remove from VIN interface description properties that are not listed as
> supported in bindings documentation, as their value is fixed in the hardware.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  arch/arm/boot/dts/r8a7790-lager.dts   | 2 --
>  arch/arm/boot/dts/r8a7791-koelsch.dts | 2 --
>  arch/arm/boot/dts/r8a7793-gose.dts    | 2 --
>  3 files changed, 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index 092610e..250f698 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -888,8 +888,6 @@
>  			bus-width = <24>;
>  			hsync-active = <0>;
>  			vsync-active = <0>;
> -			pclk-sample = <1>;
> -			data-active = <1>;
>  		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
> index 8ab793d..1becb79 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -860,8 +860,6 @@
>  			bus-width = <24>;
>  			hsync-active = <0>;
>  			vsync-active = <0>;
> -			pclk-sample = <1>;
> -			data-active = <1>;
>  		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
> index aa209f6..f57a7ae 100644
> --- a/arch/arm/boot/dts/r8a7793-gose.dts
> +++ b/arch/arm/boot/dts/r8a7793-gose.dts
> @@ -768,8 +768,6 @@
>  			bus-width = <24>;
>  			hsync-active = <0>;
>  			vsync-active = <0>;
> -			pclk-sample = <1>;
> -			data-active = <1>;
>  		};
>  	};
>  };
> --
> 2.7.4
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180709/3fd4f3cf/attachment-0001.sig>
