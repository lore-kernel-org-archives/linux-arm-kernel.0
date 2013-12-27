From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 27 Dec 2013 12:59:08 -0500
Subject: [PATCH RFCv1 5/6] ARM: mvebu: update Armada 370/XP DT to use
 new coherency compatible string
In-Reply-To: <1388067146-18111-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1388067146-18111-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1388067146-18111-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20131227175908.GB19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

Including the MLs.

On Thu, Dec 26, 2013 at 03:12:25PM +0100, Thomas Petazzoni wrote:
> Update the common Armada 370 and Armada XP Device Tree files to use
> the new compatible string for the coherency fabric.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index 7f10f62..c32f522 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -117,7 +117,7 @@
>  			};
>  
>  			coherency-fabric at 20200 {
> -				compatible = "marvell,coherency-fabric";
> +				compatible = "marvell,armada-370-coherency-fabric";

Not needed, see my reply to 1/6.

thx,

Jason.

>  				reg = <0x20200 0xb0>, <0x21010 0x1c>;
>  			};
>  
> -- 
> 1.8.3.2
> 
