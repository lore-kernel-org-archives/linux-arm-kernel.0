From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Nov 2018 11:21:07 -0600
Subject: [PATCH 1/2] clk: mediatek: add clock support for MT7629 SoC
In-Reply-To: <815e38d4d74689980cd73c86d9e80fd5854cfc94.1541143168.git.ryder.lee@mediatek.com>
References: <815e38d4d74689980cd73c86d9e80fd5854cfc94.1541143168.git.ryder.lee@mediatek.com>
Message-ID: <5bea0ea7.1c69fb81.7820a.2044@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2018 at 04:43:55PM +0800, Ryder Lee wrote:
> Add all supported clocks exported from every susbystem found on MT7629 SoC.
> 
> Signed-off-by: Wenzhen Yu <wenzhen.yu@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/clk/mediatek/Kconfig           |  23 ++
>  drivers/clk/mediatek/Makefile          |   3 +
>  drivers/clk/mediatek/clk-mt7629-eth.c  | 159 ++++++++
>  drivers/clk/mediatek/clk-mt7629-hif.c  | 156 +++++++
>  drivers/clk/mediatek/clk-mt7629.c      | 723 +++++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/mt7629-clk.h | 203 +++++++++

Acked-by: Rob Herring <robh@kernel.org>

In the future, the header goes with the binding patch.

>  6 files changed, 1267 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt7629-eth.c
>  create mode 100644 drivers/clk/mediatek/clk-mt7629-hif.c
>  create mode 100644 drivers/clk/mediatek/clk-mt7629.c
>  create mode 100644 include/dt-bindings/clock/mt7629-clk.h
