From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 15 Dec 2017 15:20:29 -0200
Subject: [PATCH v2] arm: imx: dts: Remove leading 0x and 0s from bindings
 notation
In-Reply-To: <20171215171327.8513-1-malat@debian.org>
References: <20171215124631.30132-1-malat@debian.org>
 <20171215171327.8513-1-malat@debian.org>
Message-ID: <CAOMZO5D4R0o5ViiT7Z=wFro-=WxS1rwpMbZmjvMZF3A0SzSB6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Mathieu,

On Fri, Dec 15, 2017 at 3:13 PM, Mathieu Malaterre <malat@debian.org> wrote:

> diff --git a/arch/arm/boot/dts/imx6q-display5.dtsi b/arch/arm/boot/dts/imx6q-display5.dtsi
> index 4084de43d4d9..09085fde3341 100644
> --- a/arch/arm/boot/dts/imx6q-display5.dtsi
> +++ b/arch/arm/boot/dts/imx6q-display5.dtsi
> @@ -255,7 +255,7 @@
>         pinctrl-0 = <&pinctrl_i2c1>;
>         status = "okay";
>
> -       codec: tfa9879 at 6C {
> +       codec: tfa9879 at 6c {

This change is fine, but it no longer matches the Subject and commit log.
