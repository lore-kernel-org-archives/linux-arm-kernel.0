From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 21 Nov 2018 22:21:57 +0100
Subject: [PATCH 2/3] dt-bindings: mfd: atmel-usart: add DMA bindings for
 SPI mode
In-Reply-To: <CAL_JsqLO_L+rTZh70nrpBMU1+CYKct7HhNY0gLGUnU7=JVRuQw@mail.gmail.com>
References: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
 <20181121112732.15690-3-radu_nicolae.pirea@upb.ro>
 <CAL_JsqLNURZTWCb5WOyJvN-trUP9r-ueftwUOGWPnrEaQPBKSw@mail.gmail.com>
 <20181121164820.GC12656@piout.net>
 <CAL_JsqLO_L+rTZh70nrpBMU1+CYKct7HhNY0gLGUnU7=JVRuQw@mail.gmail.com>
Message-ID: <20181121212157.GD12656@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/11/2018 14:52:29-0600, Rob Herring wrote:
> On Wed, Nov 21, 2018 at 10:48 AM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > Hi Rob,
> >
> > On 21/11/2018 10:41:01-0600, Rob Herring wrote:
> > > > +Optional properties in serial and SPI mode:
> > > > +- dma bindings for dma transfer:
> > > > +       - dmas: DMA specifier, consisting of a phandle to DMA controller node,
> > > > +               memory peripheral interface and USART DMA channel ID, FIFO configuration.
> > > > +               Refer to dma.txt and atmel-dma.txt for details.
> > > > +       - dma-names: "rx" for RX channel, "tx" for TX channel.
> > >
> > > > +               dma-names = "tx", "rx";
> > >
> > > The dma-names should have a defined order.
> > >
> >
> > Why is that? Isn't the purpose of names to get rid of any particular
> > ordering?
> 
> Because a fundamental rule of DT is the order is defined and
> important. The purpose was to allow for cases that had a variable
> number of entries, but even a variable number still have a defined
> order.
> 

Thank you for the clarification!


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
