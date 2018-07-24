From: robh@kernel.org (Rob Herring)
Date: Tue, 24 Jul 2018 17:29:17 -0600
Subject: [PATCH v3 1/2] clk: meson: add DT documentation for emmc clock
 controller
In-Reply-To: <20180712211244.11428-2-yixun.lan@amlogic.com>
References: <20180712211244.11428-1-yixun.lan@amlogic.com>
 <20180712211244.11428-2-yixun.lan@amlogic.com>
Message-ID: <20180724232917.GA27041@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2018 at 09:12:43PM +0000, Yixun Lan wrote:
> Document the MMC sub clock controller driver, the potential consumer
> of this driver is MMC or NAND. Also add three clock bindings IDs which
> provided by this driver.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  .../bindings/clock/amlogic,mmc-clkc.txt       | 31 +++++++++++++++++++
>  .../clock/amlogic,meson-mmc-clkc.h            | 16 ++++++++++
>  2 files changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>  create mode 100644 include/dt-bindings/clock/amlogic,meson-mmc-clkc.h

Reviewed-by: Rob Herring <robh@kernel.org>
