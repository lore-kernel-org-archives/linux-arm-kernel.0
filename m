From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 17 Jun 2015 18:31:09 +0200
Subject: [PATCH 9/9] ARM: mvebu: adjust board name and compatible for
 Armada 388 GP
In-Reply-To: <1434456785-23696-10-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1434456785-23696-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1434456785-23696-10-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5581A0CD.30109@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 16/06/2015 14:13, Thomas Petazzoni wrote:
> As the name of the Device Tree file name suggests, the Armada 388 GP
> really contains an Armada 388 SoC, so this commit updates the board
> name and compatible string in the Device Tree file.

Actually the name of the board (the one written on the box) is DB-88F6820-GP.
And 88F6820 is the code name of Armada 385. But indeed the SoC is an Armada 388
on our boards.

Gregory

> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-388-gp.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
> index 5f53a96..605f924 100644
> --- a/arch/arm/boot/dts/armada-388-gp.dts
> +++ b/arch/arm/boot/dts/armada-388-gp.dts
> @@ -44,8 +44,8 @@
>  #include <dt-bindings/gpio/gpio.h>
>  
>  / {
> -	model = "Marvell Armada 385 GP";
> -	compatible = "marvell,a385-gp", "marvell,armada388", "marvell,armada380";
> +	model = "Marvell Armada 388 GP";
> +	compatible = "marvell,a388-gp", "marvell,armada388", "marvell,armada380";
>  
>  	chosen {
>  		stdout-path = "serial0:115200n8";
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
