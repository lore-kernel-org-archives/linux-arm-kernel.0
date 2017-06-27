From: sunil.m@techveda.org (Suniel Mahesh)
Date: Tue, 27 Jun 2017 11:16:35 +0530
Subject: [PATCH] arm: dts: omap3: Remove interrupt-parent property
In-Reply-To: <1498541590-4550-1-git-send-email-karthik@techveda.org>
References: <1498541590-4550-1-git-send-email-karthik@techveda.org>
Message-ID: <41ab5d17-620e-34b6-bd1c-33ae7bb3234c@techveda.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 June 2017 11:03 AM, karthik at techveda.org wrote:
> From: Karthik Tummala <karthik@techveda.org>
> 
Please change the subject of the patch to something which is more meaningful and 
which reflect the changes done to the code base.
> All nodes inhert "interrupt-parent" property from root
> node. So removed that property from usbhsohci, usbhsehci,
> ssi_port1, ssi_port2 nodes.
Adjust description accordingly.
> 
> Signed-off-by: Karthik Tummala <karthik@techveda.org>
> ---
>  arch/arm/boot/dts/omap3.dtsi | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index a3ff493..bdaf30c 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -713,14 +713,12 @@
>  			usbhsohci: ohci at 48064400 {
>  				compatible = "ti,ohci-omap3";
>  				reg = <0x48064400 0x400>;
> -				interrupt-parent = <&intc>;
>  				interrupts = <76>;
>  			};
>  
>  			usbhsehci: ehci at 48064800 {
>  				compatible = "ti,ehci-omap";
>  				reg = <0x48064800 0x400>;
> -				interrupt-parent = <&intc>;
>  				interrupts = <77>;
>  			};
>  		};
> @@ -831,7 +829,6 @@
>  				reg-names = "tx",
>  					    "rx";
>  
> -				interrupt-parent = <&intc>;
>  				interrupts = <67>,
>  					     <68>;
>  			};
> @@ -844,7 +841,6 @@
>  				reg-names = "tx",
>  					    "rx";
>  
> -				interrupt-parent = <&intc>;
>  				interrupts = <69>,
>  					     <70>;
>  			};
> 

Thanks
Suniel
