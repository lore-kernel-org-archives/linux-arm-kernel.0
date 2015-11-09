From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 9 Nov 2015 11:43:44 +0800
Subject: [PATCH 00/19] drm: Add Allwinner A10 display engine support
In-Reply-To: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v678TOTbAcJMbdLsg1AB-ze_hchG0Yw4or1ENwu_YzQGfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Fri, Oct 30, 2015 at 10:20 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Maxime Ripard (19):
>   clk: sunxi: Add display clock
>   clk: sunxi: Add PLL3 clock
>   clk: sunxi: Add TCON channel0 clock
>   clk: sunxi: Add TCON channel1 clock
>   clk: sunxi: add DRAM gates
>   clk: sunxi: Add Allwinner R8 AHB gates support
>   drm/panel: simple: Add timings for the Olimex LCD-OLinuXino-4.3TS
>   drm: Add Allwinner A10 Display Engine support
>   drm: sun4i: Add DT bindings documentation
>   drm: sun4i: Add RGB output
>   drm: sun4i: Add composite output
>   drm: sun4i: tv: Add PAL output standard
>   drm: sun4i: tv: Add NTSC output standard
>   ARM: sun5i: dt: Add pll3 and pll7 clocks
>   ARM: sun5i: dt: Add display and TCON clocks
>   ARM: sun5i: dt: Add DRAM gates
>   ARM: sun5i: dt: Add display blocks to the DTSI
>   ARM: sun5i: r8: Add AHB gates to the DTSI
>   ARM: sun5i: chip: Enable the TV Encoder

Can you add a patch adding the clock compatibles to
Documentation/devicetree/bindings/clock/sunxi.txt?

Thanks
ChenYu
