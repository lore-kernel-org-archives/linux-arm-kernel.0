From: robh@kernel.org (Rob Herring)
Date: Wed, 25 Jul 2018 13:09:30 -0600
Subject: [PATCH 08/16] dt-bindings: clk: at91: Document new PMC binding
In-Reply-To: <20180717222757.10253-9-alexandre.belloni@bootlin.com>
References: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
 <20180717222757.10253-9-alexandre.belloni@bootlin.com>
Message-ID: <20180725190930.GA27482@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 12:27:49AM +0200, Alexandre Belloni wrote:
> Document the new PMC binding with only one PMC node for all the PMC clocks
> instead of one node per clock as this proved to be problematic.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../devicetree/bindings/clock/at91-clock.txt  | 523 +-----------------
>  1 file changed, 21 insertions(+), 502 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
