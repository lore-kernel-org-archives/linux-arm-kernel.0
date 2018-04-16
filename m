From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 16 Apr 2018 12:09:10 +0200
Subject: [PATCH v5 4/7] dt-bindings: clock: reset: Add AXG AO Clock and
 Reset Bindings
In-Reply-To: <1523872752.2601.26.camel@baylibre.com>
References: <20180409143749.71197-1-yixun.lan@amlogic.com>
 <20180409143749.71197-5-yixun.lan@amlogic.com>
 <1523872752.2601.26.camel@baylibre.com>
Message-ID: <1523873350.5918.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome,

On Mon, 2018-04-16 at 11:59 +0200, Jerome Brunet wrote:
> On Mon, 2018-04-09 at 22:37 +0800, Yixun Lan wrote:
> > Add dt-bindings headers for the Meson-AXG's AO clock and
> > reset controller.
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> > ---
> >  include/dt-bindings/clock/axg-aoclkc.h | 26 ++++++++++++++++++++++++++
> >  include/dt-bindings/reset/axg-aoclkc.h | 20 ++++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> >  create mode 100644 include/dt-bindings/clock/axg-aoclkc.h
> >  create mode 100644 include/dt-bindings/reset/axg-aoclkc.h
> 
> Hi Philipp,
> 
> Is OK if we take this through clock tree ?
> The related reset controller is actually part of a clock controller driver.

Absolutely, this should go in together with the driver.
I see no risk of merge conflicts here.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
