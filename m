From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 21 Nov 2018 17:48:20 +0100
Subject: [PATCH 2/3] dt-bindings: mfd: atmel-usart: add DMA bindings for
 SPI mode
In-Reply-To: <CAL_JsqLNURZTWCb5WOyJvN-trUP9r-ueftwUOGWPnrEaQPBKSw@mail.gmail.com>
References: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
 <20181121112732.15690-3-radu_nicolae.pirea@upb.ro>
 <CAL_JsqLNURZTWCb5WOyJvN-trUP9r-ueftwUOGWPnrEaQPBKSw@mail.gmail.com>
Message-ID: <20181121164820.GC12656@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 21/11/2018 10:41:01-0600, Rob Herring wrote:
> > +Optional properties in serial and SPI mode:
> > +- dma bindings for dma transfer:
> > +       - dmas: DMA specifier, consisting of a phandle to DMA controller node,
> > +               memory peripheral interface and USART DMA channel ID, FIFO configuration.
> > +               Refer to dma.txt and atmel-dma.txt for details.
> > +       - dma-names: "rx" for RX channel, "tx" for TX channel.
> 
> > +               dma-names = "tx", "rx";
> 
> The dma-names should have a defined order.
> 

Why is that? Isn't the purpose of names to get rid of any particular
ordering?


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
