From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 20 Jun 2018 20:44:49 +0200
Subject: [PATCH v5 1/5] dt-bindings: clk: at91: add an I2S mux clock
In-Reply-To: <20180620154759.GA4755@rob-hp-laptop>
References: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
 <20180618141239.10892-2-codrin.ciubotariu@microchip.com>
 <20180620154759.GA4755@rob-hp-laptop>
Message-ID: <20180620184449.GH7737@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/2018 09:47:59-0600, Rob Herring wrote:
> On Mon, Jun 18, 2018 at 05:12:35PM +0300, Codrin Ciubotariu wrote:
> > The I2S mux clock can be used to select the I2S input clock. The
> > available parents are the peripheral and the generated clocks.
> > 
> > Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> > ---
> > 
> > Changes in v5:
> > 	- specified clock's parent;
> > 	- added a newline before adding the clock's compatible string;
> > 
> >  .../devicetree/bindings/clock/at91-clock.txt  | 35 +++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> 
> Well, since Alexandre promises all this is going to get re-worked soon:
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks, I'm planning to send a first version next week, it will be based
on top of that series.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
