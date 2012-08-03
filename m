From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 03 Aug 2012 15:29:10 +0200
Subject: [PATCH 4/4] arm: mvebu: add address decoding controller to the DT
In-Reply-To: <1343999430-31816-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1343999430-31816-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1343999430-31816-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <501BD226.3020708@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/2012 03:10 PM, Thomas Petazzoni wrote:
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index 6b6b932..16cc82c 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -63,6 +63,11 @@
>  			       reg = <0xd0020300 0x30>;
>  			       interrupts = <37>, <38>, <39>, <40>;
>  		};
> +
> +		addr-decoding at d0020000 {
> +			compatible = "marvell,armada-addr-decoding-controller";
> +			reg = <0xd0020000 0x258>;
> +		};
>  	};
>  };
>  
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
