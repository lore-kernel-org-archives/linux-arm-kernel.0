From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 09 Aug 2013 08:45:10 +0200
Subject: [PATCHv8 08/10] ARM: mvebu: the MPIC now provides MSI controller
 features
In-Reply-To: <1376000268-18397-9-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1376000268-18397-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1376000268-18397-9-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <52048FF6.6030904@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2013 00:17, Thomas Petazzoni wrote:
> Adds the 'msi-controller' property to the main interrupt controller
> Device Tree node, to indicate that it can now behave as a MSI
> controller.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Reviewed-by: Thierry Reding <thierry.reding@gmail.com>
> Tested-by: Daniel Price <daniel.price@gmail.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index 90b1176..ac0bbc0 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -56,6 +56,7 @@
>  				#interrupt-cells = <1>;
>  				#size-cells = <1>;
>  				interrupt-controller;
> +				msi-controller;
>  			};
>  
>  			coherency-fabric at 20200 {
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
