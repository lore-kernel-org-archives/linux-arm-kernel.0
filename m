From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 20 Sep 2016 12:51:58 +0100
Subject: [PATCH] ARM: tegra: nyan: Mark all USB ports as host
In-Reply-To: <20160918102852.6593-1-contact@paulk.fr>
References: <20160918102852.6593-1-contact@paulk.fr>
Message-ID: <31a2d04c-91d5-807d-3a2d-76cc3e607f4a@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 18/09/16 11:28, Paul Kocialkowski wrote:
> Nyan boards only have host USB ports (2 external, 1 internal), there is
> no OTG-enabled connector.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/boot/dts/tegra124-nyan.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
> index 18db797..254b2ee 100644
> --- a/arch/arm/boot/dts/tegra124-nyan.dtsi
> +++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
> @@ -435,7 +435,7 @@
>  			usb2-0 {
>  				vbus-supply = <&vdd_usb1_vbus>;
>  				status = "okay";
> -				mode = "otg";
> +				mode = "host";
>  			};
>  
>  			usb2-1 {

Sounds correct to me, so ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
