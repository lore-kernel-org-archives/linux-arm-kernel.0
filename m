From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 21 Dec 2015 17:49:58 +0100
Subject: [PATCH v2 2/9] ARM: mvebu: kirkwood: Add compatible property to
 "partitions" node
In-Reply-To: <1450694033-27717-3-git-send-email-geert+renesas@glider.be>
 (Geert Uytterhoeven's message of "Mon, 21 Dec 2015 11:33:46 +0100")
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
 <1450694033-27717-3-git-send-email-geert+renesas@glider.be>
Message-ID: <87vb7rrbk9.fsf@free-electrons.com>
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

Applied on mvebu/dt

Thanks,

Gregory

> ---
> v2:
>   - New.
> ---
>  arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts b/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts
> index 1db6f2c506cce320..8082d64266a37c33 100644
> --- a/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts
> +++ b/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts
> @@ -131,6 +131,7 @@
>  	chip-delay = <40>;
>  	status = "okay";
>  	partitions {
> +		compatible = "fixed-partitions";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  
> -- 
> 1.9.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
