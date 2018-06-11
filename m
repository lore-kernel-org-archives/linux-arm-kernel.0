From: robh@kernel.org (Rob Herring)
Date: Mon, 11 Jun 2018 12:22:43 -0600
Subject: [PATCH v3 2/6] clk: ti: dra7: Add clkctrl clock data for the
 mcan clocks
In-Reply-To: <20180606060826.14671-3-faiz_abbas@ti.com>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
 <20180606060826.14671-3-faiz_abbas@ti.com>
Message-ID: <20180611182243.GA12727@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 06, 2018 at 11:38:22AM +0530, Faiz Abbas wrote:
> Add clkctrl data for the m_can clocks and register it within the
> clkctrl driver
> 
> CC: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/clk/ti/clk-7xx.c         | 1 +
>  include/dt-bindings/clock/dra7.h | 1 +

Acked-by: Rob Herring <robh@kernel.org>

>  2 files changed, 2 insertions(+)
> 
