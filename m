From: robh@kernel.org (Rob Herring)
Date: Wed, 25 Jul 2018 13:10:34 -0600
Subject: [PATCH 09/16] clk: at91: add new DT lookup function
In-Reply-To: <20180717222757.10253-10-alexandre.belloni@bootlin.com>
References: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
 <20180717222757.10253-10-alexandre.belloni@bootlin.com>
Message-ID: <20180725191034.GA29658@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 12:27:50AM +0200, Alexandre Belloni wrote:
> Add a new DT lookup function to lookup for PMC clocks.
> 
> Note that the #ifndef AT91_PMC_MOSCS section will be removed once all the
> platforms are converted.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/clk/at91/pmc.c           | 34 ++++++++++++++++++++++++++++++++

>  include/dt-bindings/clock/at91.h | 14 +++++++++++++

Acked-by: Rob Herring <robh@kernel.org>

>  2 files changed, 48 insertions(+)
