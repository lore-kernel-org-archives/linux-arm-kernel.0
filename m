From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 31 May 2017 11:52:47 +0200
Subject: [PATCH v2 1/5] dts: gpio_atmel: adapt binding doc to reality
In-Reply-To: <20170526190703.t5fab33peh2cmobm@taurus.defre.kleine-koenig.org>
References: <20170526185214.GB20946@lunn.ch>
 <20170526190703.t5fab33peh2cmobm@taurus.defre.kleine-koenig.org>
Message-ID: <20170531095247.5g4zibmlc6qzyqwu@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/05/2017 at 21:07:03 +0200, Uwe Kleine-K?nig wrote:
> The second cell in a gpio reference is used to pass GPIO_ACTIVE_LOW or
> GPIO_ACTIVE_HIGH. The gpio device can also be used as irq controller and
> a reference can contain the IRQ_TYPE_* values in the second cell.
> 
> Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
> ---
> On Fri, May 26, 2017 at 08:52:14PM +0200, Andrew Lunn wrote:
> > > +- interrupt-controller: Marks the device node as a GPIO controller.
> > 
> > Interrupt controller, not GPIO controller.
> > 
> > > +- #interrupt-cells: Should be two. The first cell is the pin number and the
> > > +  second cell is used to specify irq type flags:
> > > +      1 = low-to-high edge triggered.
> > > +      2 = high-to-low edge triggered.
> > > +      4 = active high level-sensitive.
> > > +      8 = active low level-sensitive.
> > 
> > Maybe just reference interrupts.txt?
> 
> ack for both and changed in this v2.
> 
> Thanks
> Uwe
> 
>  Documentation/devicetree/bindings/gpio/gpio_atmel.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
