From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 5 Nov 2012 11:20:59 +0800
Subject: [PATCH 0/2] Pinctrl muxing for the Crystalfontz boards
In-Reply-To: <1351958348-7327-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1351958348-7327-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20121105032057.GC26528@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 03, 2012 at 04:59:06PM +0100, Maxime Ripard wrote:
> Hi all,
> 
> This patch serie add the hogpins to explicitly mux the GPIOs used
> across the device tree as such for the two Crystalfontz boards, and
> make the gpio-led driver use pinctrl.
> 
> This serie goes on top of the i2c-mux-gpios patches I sent on this
> list.

I do not see that dependency at all, so just applied both patches.

Shawn

> 
> Maxime
> 
> Maxime Ripard (2):
>   ARM: dts: cfa10036: Use pinctrl for power led
>   ARM: dts: mxs: Add hog pins to Crystalfontz boards
> 
>  arch/arm/boot/dts/imx28-cfa10036.dts |   27 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx28-cfa10049.dts |   16 ++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> -- 
> 1.7.9.5
> 
