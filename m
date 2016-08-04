From: robh@kernel.org (Rob Herring)
Date: Thu, 4 Aug 2016 12:04:24 -0500
Subject: [PATCH v5 2/2] clk: uniphier: add clock data for UniPhier SoCs
In-Reply-To: <1470111307-21078-3-git-send-email-yamada.masahiro@socionext.com>
References: <1470111307-21078-1-git-send-email-yamada.masahiro@socionext.com>
 <1470111307-21078-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160804170424.GA10741@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2016 at 01:14:54PM +0900, Masahiro Yamada wrote:
> Add clock data arrays for all UniPhier SoCs.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  .../devicetree/bindings/clock/uniphier-clock.txt   | 134 ++++++++++++++++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/uniphier/Makefile                      |   3 +
>  drivers/clk/uniphier/clk-uniphier-core.c           |  91 +++++++++++++
>  drivers/clk/uniphier/clk-uniphier-mio.c            | 103 ++++++++++++++
>  drivers/clk/uniphier/clk-uniphier-peri.c           |  59 ++++++++
>  drivers/clk/uniphier/clk-uniphier-sys.c            | 151 +++++++++++++++++++++
>  drivers/clk/uniphier/clk-uniphier.h                |  13 ++
>  7 files changed, 554 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/uniphier-clock.txt
>  create mode 100644 drivers/clk/uniphier/clk-uniphier-mio.c
>  create mode 100644 drivers/clk/uniphier/clk-uniphier-peri.c
>  create mode 100644 drivers/clk/uniphier/clk-uniphier-sys.c
