From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 17 May 2013 19:16:36 +0200
Subject: [RFC PATCH v4 05/18] ARM: dts: armada-370-xp: cpus/cpu node dts
 updates
In-Reply-To: <1368804061-4421-6-git-send-email-lorenzo.pieralisi@arm.com>
References: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1368804061-4421-6-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <519665F4.8090707@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/2013 05:20 PM, Lorenzo Pieralisi wrote:
> This patch updates the in-kernel dts files according to the latest cpus
> and cpu bindings updates for ARM.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index 272bbc6..2407903 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -23,8 +23,12 @@
>  	compatible = "marvell,armada-370-xp";
>  
>  	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  		cpu at 0 {
>  			compatible = "marvell,sheeva-v7";
> +			device_type = "cpu";
> +			reg = <0>;
>  		};
>  	};
>  
> 

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
