From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 27 Jul 2016 18:00:15 +0200
Subject: [PATCH 04/18] ARM: mvebu: a385-db-ap: enable USB (orion-ehci) port
In-Reply-To: <1469105055-25181-5-git-send-email-jaz@semihalf.com> (Grzegorz
 Jaszczyk's message of "Thu, 21 Jul 2016 14:44:00 +0200")
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
 <1469105055-25181-5-git-send-email-jaz@semihalf.com>
Message-ID: <87oa5jm5ps.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grzegorz,
 
 On jeu., juil. 21 2016, Grzegorz Jaszczyk <jaz@semihalf.com> wrote:

> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>


Here agina, as pointed by Andrew a commit log entry would be
nice. Except this:

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/armada-385-db-ap.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
> index 2d3fd6e..a18f516 100644
> --- a/arch/arm/boot/dts/armada-385-db-ap.dts
> +++ b/arch/arm/boot/dts/armada-385-db-ap.dts
> @@ -155,6 +155,10 @@
>  				bm,pool-short = <3>;
>  			};
>  
> +			usb at 58000 {
> +				status = "okay";
> +			};
> +
>  			/* CON4 */
>  			ethernet at 70000 {
>  				pinctrl-names = "default";
> -- 
> 1.8.3.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
