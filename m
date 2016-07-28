From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 28 Jul 2016 14:55:41 +0200
Subject: [PATCH 16/18] ARM: mvebu: a398-db: enable supported usb interfaces
In-Reply-To: <1469105055-25181-18-git-send-email-jaz@semihalf.com> (Grzegorz
 Jaszczyk's message of "Thu, 21 Jul 2016 14:44:13 +0200")
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
 <1469105055-25181-18-git-send-email-jaz@semihalf.com>
Message-ID: <87popxkjle.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grzegorz,
 
 On jeu., juil. 21 2016, Grzegorz Jaszczyk <jaz@semihalf.com> wrote:

Change the prefix to "ARM: dts: mvebu: armada-398-db:"

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> ---
>  arch/arm/boot/dts/armada-398-db.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/armada-398-db.dts b/arch/arm/boot/dts/armada-398-db.dts
> index 788c3ba..969b49f 100644
> --- a/arch/arm/boot/dts/armada-398-db.dts
> +++ b/arch/arm/boot/dts/armada-398-db.dts
> @@ -108,6 +108,10 @@
>  				status = "okay";
>  			};
>  
> +			usb at 58000 {
> +				status = "okay";
> +			};
> +
>  			flash at d0000 {
>  				status = "okay";
>  				pinctrl-0 = <&nand_pins>;
> @@ -132,6 +136,10 @@
>  					reg = <0x1000000 0x3f000000>;
>  				};
>  			};
> +
> +			usb3 at f8000 {
> +				status = "okay";
> +			};
>  		};
>  
>  		pcie-controller {
> -- 
> 1.8.3.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
