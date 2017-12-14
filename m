From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 14 Dec 2017 10:59:09 +0100
Subject: [PATCH v7 4/6] clk: meson-axg: add clock controller drivers
In-Reply-To: <20171211141348.22048-5-yixun.lan@amlogic.com>
References: <20171211141348.22048-1-yixun.lan@amlogic.com>
 <20171211141348.22048-5-yixun.lan@amlogic.com>
Message-ID: <1513245549.32163.3.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-12-11 at 22:13 +0800, Yixun Lan wrote:
> From: Qiufang Dai <qiufang.dai@amlogic.com>
> 
> Add clock controller drivers for Amlogic Meson-AXG SoC.
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Qiufang Dai <qiufang.dai@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Applied to next/drivers

Thx

> ---
>  arch/arm64/Kconfig.platforms |   1 +
>  drivers/clk/meson/Kconfig    |   8 +
>  drivers/clk/meson/Makefile   |   1 +
>  drivers/clk/meson/axg.c      | 936 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/axg.h      | 126 ++++++
>  5 files changed, 1072 insertions(+)
>  create mode 100644 drivers/clk/meson/axg.c
>  create mode 100644 drivers/clk/meson/axg.h
