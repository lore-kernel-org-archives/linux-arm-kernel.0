From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 14 Jan 2014 15:58:29 +0100
Subject: [PATCH v2 3/3] ARM: mvebu: update the SATA compatible string
 for Armada 370/XP
In-Reply-To: <1389711007-7239-4-git-send-email-simon.guinot@sequanux.org>
References: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
 <1389711007-7239-4-git-send-email-simon.guinot@sequanux.org>
Message-ID: <52D55095.3030305@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On 14/01/2014 15:50, Simon Guinot wrote:
> This patch updates the Armada 370/XP SATA node with the new compatible
> string "marvell,armada-370-xp-sata".

Usually we try to use the name of the first SoC instead of a family name.
So here it should be "marvell,armada-370-sata"

Thanks,

Gregory



> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Lior Amsalem <alior@marvell.com>
> Cc: stable at vger.kernel.org
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index 7f10f627ae5b..b5def2416800 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -152,7 +152,7 @@
>  			};
>  
>  			sata at a0000 {
> -				compatible = "marvell,orion-sata";
> +				compatible = "marvell,armada-370-xp-sata";
>  				reg = <0xa0000 0x5000>;
>  				interrupts = <55>;
>  				clocks = <&gateclk 15>, <&gateclk 30>;
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
