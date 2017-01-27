From: robh@kernel.org (Rob Herring)
Date: Fri, 27 Jan 2017 15:13:48 -0600
Subject: [PATCH 05/11] clk: sunxi-ng: Add A80 CCU
In-Reply-To: <20170124023230.3990-6-wens@csie.org>
References: <20170124023230.3990-1-wens@csie.org>
 <20170124023230.3990-6-wens@csie.org>
Message-ID: <20170127211348.quf2mfjf7bp37sqs@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 10:32:24AM +0800, Chen-Yu Tsai wrote:
> Add support for the main clock unit found in the A80.
> 
> Note that on the A80, some subsystems have separate clock controllers
> downstream of the main clock unit. These include the MMC, USB, and
> display engine subsystems.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../devicetree/bindings/clock/sunxi-ccu.txt        |    1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/sunxi-ng/Kconfig                       |   10 +
>  drivers/clk/sunxi-ng/Makefile                      |    1 +
>  drivers/clk/sunxi-ng/ccu-sun9i-a80.c               | 1223 ++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun9i-a80.h               |   57 +
>  include/dt-bindings/clock/sun9i-a80-ccu.h          |  162 +++
>  include/dt-bindings/reset/sun9i-a80-ccu.h          |  102 ++
>  7 files changed, 1556 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun9i-a80.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun9i-a80.h
>  create mode 100644 include/dt-bindings/clock/sun9i-a80-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun9i-a80-ccu.h
