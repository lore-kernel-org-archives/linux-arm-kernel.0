From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 14 Dec 2017 10:58:19 +0100
Subject: [PATCH v7 3/6] clk: meson-axg: add clocks dt-bindings required
 header
In-Reply-To: <20171211141348.22048-4-yixun.lan@amlogic.com>
References: <20171211141348.22048-1-yixun.lan@amlogic.com>
 <20171211141348.22048-4-yixun.lan@amlogic.com>
Message-ID: <1513245499.32163.2.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-12-11 at 22:13 +0800, Yixun Lan wrote:
> From: Qiufang Dai <qiufang.dai@amlogic.com>
> 
> Add the required header for the clocks ID dt-bindings
> exported from various subsystem in the Meson-AXG SoC.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Qiufang Dai <qiufang.dai@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Applied to next/dt

Thx

> ---
>  include/dt-bindings/clock/axg-clkc.h | 71 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 include/dt-bindings/clock/axg-clkc.h
