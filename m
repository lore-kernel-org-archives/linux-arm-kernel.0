From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 20 Nov 2017 11:33:11 +0100
Subject: [PATCH v2 1/2] pinctrl: meson-axg: Introduce a pinctrl pinmux
 ops for Meson-AXG SoC
In-Reply-To: <20171120100825.16613-2-yixun.lan@amlogic.com>
References: <20171120100825.16613-1-yixun.lan@amlogic.com>
 <20171120100825.16613-2-yixun.lan@amlogic.com>
Message-ID: <1511173991.6971.7.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-11-20 at 18:08 +0800, Yixun Lan wrote:
> From: Xingyu Chen <xingyu.chen@amlogic.com>
> 
> The pin controller has been updated in the Amlogic Meson AXG series,
> which use continuous 4-bit register to select function for each pin.
> In order to support this, a new pinmux operations "meson_axg_pmx_ops"
> has been added.
> 
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
