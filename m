From: avinashphilip@ti.com (Philip, Avinash)
Date: Wed, 23 Jan 2013 06:32:15 +0000
Subject: [PATCH 1/3] ARM: dts: AM33XX: Add ELM node
In-Reply-To: <877gn69sb9.fsf@dell.be.48ers.dk>
References: <1358491295-4022-1-git-send-email-avinashphilip@ti.com>
 <1358491295-4022-2-git-send-email-avinashphilip@ti.com>
 <877gn69sb9.fsf@dell.be.48ers.dk>
Message-ID: <518397C60809E147AF5323E0420B992E3EA62B2D@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 02:17:38, Peter Korsgaard wrote:
> >>>>> "Philip" == Philip Avinash <avinashphilip@ti.com> writes:
> 
>  Philip> From: "Philip, Avinash" <avinashphilip@ti.com>
>  Philip> Add ELM data node to AM33XX device tree file.
> 
>  Philip> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
>  Philip> ---
>  Philip>  arch/arm/boot/dts/am33xx.dtsi |    8 ++++++++
>  Philip>  1 file changed, 8 insertions(+)
> 
>  Philip> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>  Philip> index c2f14e8..eaef5e7 100644
>  Philip> --- a/arch/arm/boot/dts/am33xx.dtsi
>  Philip> +++ b/arch/arm/boot/dts/am33xx.dtsi
>  Philip> @@ -385,5 +385,13 @@
>  Philip>  				mac-address = [ 00 00 00 00 00 00 ];
>  Philip>  			};
>  Philip>  		};
>  Philip> +
>  Philip> +		elm: elm at 48080000 {
>  Philip> +			compatible	= "ti,am33xx-elm";
> 
> Please drop the <tab> after compatible.

I will replace with space and submit another version

> 
> Other than that it looks goood.
> 
> Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

Thanks
Avinash

> 
> -- 
> Bye, Peter Korsgaard
> 
