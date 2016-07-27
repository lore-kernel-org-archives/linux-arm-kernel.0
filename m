From: robh@kernel.org (Rob Herring)
Date: Wed, 27 Jul 2016 09:59:07 -0500
Subject: [PATCH 8/9] clk: sunxi-ng: Add A31/A31s clocks
In-Reply-To: <1469516671-19377-9-git-send-email-wens@csie.org>
References: <1469516671-19377-1-git-send-email-wens@csie.org>
 <1469516671-19377-9-git-send-email-wens@csie.org>
Message-ID: <20160727145907.GA24979@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 03:04:30PM +0800, Chen-Yu Tsai wrote:
> Add a new style driver for the clock control unit in Allwinner A31/A31s.
> 
> A few clocks are still missing:
> 
>     - EMAC clock
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../devicetree/bindings/clock/sunxi-ccu.txt        |    3 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/sunxi-ng/Kconfig                       |   10 +
>  drivers/clk/sunxi-ng/Makefile                      |    1 +
>  drivers/clk/sunxi-ng/ccu-sun6i-a31.c               | 1230 ++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun6i-a31.h               |   72 ++
>  include/dt-bindings/clock/sun6i-a31-ccu.h          |  187 +++
>  include/dt-bindings/reset/sun6i-a31-ccu.h          |  106 ++
>  7 files changed, 1608 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun6i-a31.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun6i-a31.h
>  create mode 100644 include/dt-bindings/clock/sun6i-a31-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun6i-a31-ccu.h
