From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 21 Dec 2015 17:48:48 +0100
Subject: [PATCH v2 1/9] ARM: mvebu: ix4-300d: Add compatible property to
 "partitions" node
In-Reply-To: <1450694033-27717-2-git-send-email-geert+renesas@glider.be>
 (Geert Uytterhoeven's message of "Mon, 21 Dec 2015 11:33:45 +0100")
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
 <1450694033-27717-2-git-send-email-geert+renesas@glider.be>
Message-ID: <87zix3rbm7.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,
 
 On lun., d?c. 21 2015, Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
> property to "partitions" node"), the "partitions" subnode of an SPI
> FLASH device node must have a compatible property. The partitions are no
> longer detected if it is not present.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Brian Norris <computersforpeace@gmail.com>

Applied on mvebu/dt (with the hope that it is still time to push it to
arm-soc)

Thanks,

Gregory

> ---
> v2:
>   - Add Acked-by.
> ---
>  arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
> index 13cf69a8d0fb392b..fb9e1bbf23385b85 100644
> --- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
> +++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
> @@ -152,6 +152,7 @@
>  				nand-on-flash-bbt;
>  
>  				partitions {
> +					compatible = "fixed-partitions";
>  					#address-cells = <1>;
>  					#size-cells = <1>;
>  
> -- 
> 1.9.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
