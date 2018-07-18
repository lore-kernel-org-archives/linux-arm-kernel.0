From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 18 Jul 2018 16:33:06 +0100
Subject: [PATCH] arm64: dts: hikey: Remove keep-power-in-suspend property
In-Reply-To: <20180713160231.25165-1-ryan@edited.us>
References: <20180713160231.25165-1-ryan@edited.us>
Message-ID: <5B4F5DB2.30505@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryan,

On 2018/7/13 17:02, Ryan Grachek wrote:
> Remove the keep-power-in-suspend property because it keeps wifi power
> on during suspend. This property is only required when enabling WoWLAN
> and should only be enabled based on need.
> 
> Signed-off-by: Ryan Grachek <ryan@edited.us>

Thanks!
Applied to the hisilicon dt tree.

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index 7f12624f6c8e..f4964bee6a1a 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -323,7 +323,6 @@
>  			bus-width = <0x4>;
>  			non-removable;
>  			cap-power-off-card;
> -			keep-power-in-suspend;
>  			vmmc-supply = <&reg_vdd_3v3>;
>  			mmc-pwrseq = <&wl1835_pwrseq>;
>  
> 
