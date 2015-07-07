From: robherring2@gmail.com (Rob Herring)
Date: Tue, 7 Jul 2015 09:53:03 -0500
Subject: [PATCH 3/3] ARM: dts: UniPhier: add USB EHCI device nodes
In-Reply-To: <1436154450-21102-4-git-send-email-yamada.masahiro@socionext.com>
References: <1436154450-21102-1-git-send-email-yamada.masahiro@socionext.com>
 <1436154450-21102-4-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAL_JsqJ_5SvSqfhtTYKmj9f2E0w0XLkekdOksDY2VZf7r6ZB+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 5, 2015 at 10:47 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Get USB 2.0 host controllers available with generic-ehci bindings.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

> diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
> index 1261e6d..b042711 100644
> --- a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
> +++ b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
> @@ -127,6 +127,27 @@
>                         reg = <0x59800000 0x2000>;
>                 };
>
> +               usb0: usb at 5a800100 {
> +                       compatible = "generic-ehci";

You should also have a chip specific compatible string in addition to
generic-ehci.

Rob
