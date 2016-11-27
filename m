From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 27 Nov 2016 22:17:27 +0100
Subject: [PATCH] ARM: dts: vf610-zii-dev-rev-b: Add missing newline
In-Reply-To: <1480276484-5482-1-git-send-email-afaerber@suse.de>
References: <1480276484-5482-1-git-send-email-afaerber@suse.de>
Message-ID: <20161127211727.GB13318@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 27, 2016 at 08:54:44PM +0100, Andreas F?rber wrote:
> Found while reviewing Marvell dsa bindings usage.

Hi Andreas

It is good practice to put the maintainer you expect to accept the
patch on the To: line. You have at least two different maintainers on
Cc: so it is currently ambiguous. And these lists can be high volume,
so without a copy in the maintainers inbox, patches can be overlooked.

> Fixes: f283745b3caf ("arm: vf610: zii devel b: Add support for switch interrupts")
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


> ---
>  arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
> index 7ea617e47fe4..958b4c42d320 100644
> --- a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
> +++ b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
> @@ -153,7 +153,8 @@
>  					switch0phy1: switch1phy0 at 1 {
>  						reg = <1>;
>  						interrupt-parent = <&switch0>;
> -						interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;					};
> +						interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
> +					};
>  					switch0phy2: switch1phy0 at 2 {
>  						reg = <2>;
>  						interrupt-parent = <&switch0>;
> -- 
> 2.6.6
> 
