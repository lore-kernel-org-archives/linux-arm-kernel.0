From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Sat, 26 Oct 2013 02:36:24 +0200
Subject: [PATCHv9 30/43] ARM: dts: am33xx clock data
In-Reply-To: <1382716658-6964-31-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
 <1382716658-6964-31-git-send-email-t-kristo@ti.com>
Message-ID: <1382747784.6200.4.camel@polaris.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-10-25 at 18:57 +0300, Tero Kristo wrote:
> +       mcasp0_fck: mcasp0_fck {
> +               #clock-cells = <0>;
> +               compatible = "fixed-factor-clock";
> +               clocks = <&sys_clkin_ck>;
> +               clock-mult = <1>;
> +               clock-div = <1>;
> +       };
> +
> +       mcasp1_fck: mcasp1_fck {
> +               #clock-cells = <0>;
> +               compatible = "fixed-factor-clock";
> +               clocks = <&sys_clkin_ck>;
> +               clock-mult = <1>;
> +               clock-div = <1>;
> +       };

What is you use case for these clocks with a fixed factor of 1? Wouldn't
it be simpler to just use sys_clkin_ck from the devices?

Regards,
Jan
