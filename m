From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 1 Dec 2015 09:59:40 +0100
Subject: [PATCH v2 2/3] ARM: dts: sun8i: Add Allwinner A83T dtsi
In-Reply-To: <CAEzqOZsiwbaKwH4J5CjaHoX6rdgj6kq3opvBUXiGJRfum_Se8Q@mail.gmail.com>
References: <1445557577-27383-1-git-send-email-vishnupatekar0510@gmail.com>
 <1445557577-27383-3-git-send-email-vishnupatekar0510@gmail.com>
 <20151025202012.GT10947@lukather>
 <CAEzqOZsiwbaKwH4J5CjaHoX6rdgj6kq3opvBUXiGJRfum_Se8Q@mail.gmail.com>
Message-ID: <20151201085940.GC29263@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Mon, Nov 30, 2015 at 02:09:14AM +0800, Vishnu Patekar wrote:
> >> +                     reg = <0x01c20800 0x400>;
> >> +                     clocks = <&osc24M>;
> >> +                     gpio-controller;
> >> +                     interrupt-controller;
> >> +                     #interrupt-cells = <3>;
> >> +                     #gpio-cells = <3>;
> >> +
> >> +                     i2c0_pins_a: i2c0 at 0 {
> >> +                             allwinner,pins = "PH0", "PH1";
> >> +                             allwinner,function = "i2c0";
> >> +                             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> >> +                             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >> +                     };
> >> +
> >> +                     i2c1_pins_a: i2c1 at 0 {
> >> +                             allwinner,pins = "PH2", "PH3";
> >> +                             allwinner,function = "i2c1";
> >> +                             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> >> +                             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >> +                     };
> >> +
> >> +                     i2c2_pins_a: i2c2 at 0 {
> >> +                             allwinner,pins = "PH4", "PH5";
> >> +                             allwinner,function = "i2c2";
> >> +                             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> >> +                             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >> +                     };
> >> +
> >> +                     mmc0_pins_a: mmc0 at 0 {
> >> +                             allwinner,pins = "PF0", "PF1", "PF2",
> >> +                                              "PF3", "PF4", "PF5";
> >> +                             allwinner,function = "mmc0";
> >> +                             allwinner,drive = <SUN4I_PINCTRL_30_MA>;
> >> +                             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >> +                     };
> >> +
> >> +                     mmc1_pins_a: mmc1 at 0 {
> >> +                             allwinner,pins = "PG0", "PG1", "PG2",
> >> +                                              "PG3", "PG4", "PG5";
> >> +                             allwinner,function = "mmc1";
> >> +                             allwinner,drive = <SUN4I_PINCTRL_30_MA>;
> >> +                             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >> +                     };
> >> +
> >> +                     mmc2_8bit_pins: mmc2_8bit {
> >> +                             allwinner,pins = "PC5", "PC6", "PC8",
> >> +                                              "PC9", "PC10", "PC11",
> >> +                                              "PC12", "PC13", "PC14",
> >> +                                              "PC15";
> >> +                             allwinner,function = "mmc2";
> >> +                             allwinner,drive = <SUN4I_PINCTRL_30_MA>;
> >> +                             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >> +                     };
> >> +
> >> +                     uart0_pins_a: uart0 at 0 {
> >> +                             allwinner,pins = "PF2", "PF4";
> >> +                             allwinner,function = "uart0";
> >> +                             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> >> +                             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >> +                     };
> >> +
> >> +                     uart0_pins_b: uart0 at 1 {
> >> +                             allwinner,pins = "PB9", "PB10";
> >> +                             allwinner,function = "uart0";
> >> +                             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> >> +                             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >> +                     };
> >
> > Are you going to use all these options?
>
> Not, only uart0_pins_a and uart0_pins_b and mmc0_pins_a will be used for now.
> As, these are not enabled, I don't see any harm in keeping those here.

It bloats the DT for no particular reason.

> Let me know in case you want to remove, I'll do it.

Yes, please.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151201/2217a184/attachment.sig>
