From: robh@kernel.org (Rob Herring)
Date: Wed, 27 Aug 2014 07:09:39 -0500
Subject: [PATCH] ARM: dts: calxeda: Correct memory map syntax
In-Reply-To: <1409113099-15884-1-git-send-email-horms+renesas@verge.net.au>
References: <1409113099-15884-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAL_Jsq+7iCz7rs=msnbJM1Q=Okw3S7GBB1FNabPb5-Gw9C6rcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 11:18 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Correct a syntax error by using two comma-delimited 32 bit values
> rather than a single 64 bit value.
>
> This is a documentation fix and should have no run-time affect.
>
> This problem was introduced by 7d6ab9b8620bbca6
> ("ARM: dts: Add Calxeda ECX-2000 support") in v3.7.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  arch/arm/boot/dts/ecx-2000.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/ecx-2000.dts b/arch/arm/boot/dts/ecx-2000.dts
> index 2ccbb57f..97f9807 100644
> --- a/arch/arm/boot/dts/ecx-2000.dts
> +++ b/arch/arm/boot/dts/ecx-2000.dts
> @@ -69,7 +69,7 @@
>                 reg = <0x00000000 0x00000000 0x00000000 0xff800000>;
>         };
>
> -       memory at 200000000 {
> +       memory at 2,00000000 {
>                 name = "memory";
>                 device_type = "memory";
>                 reg = <0x00000002 0x00000000 0x00000003 0x00000000>;
> --
> 2.0.1
>
