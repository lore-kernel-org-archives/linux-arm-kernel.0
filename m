From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue, 04 Oct 2016 11:32:53 +1030
Subject: [PATCH 7/8] pinctrl: aspeed-g4: Add mux configuration for all pins
In-Reply-To: <20161003190833.GA3065@rob-hp-laptop>
References: <cover.115463f791b69859c5ce9dafd61a5755ea039f4b.1474986045.git-series.andrew@aj.id.au>
 <e0d8fa6cd444972e6f048f98da98f0439e6ca39b.1474986045.git-series.andrew@aj.id.au>
 <20161003190833.GA3065@rob-hp-laptop>
Message-ID: <1475542973.5030.1.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-10-03 at 14:08 -0500, Rob Herring wrote:
> On Wed, Sep 28, 2016 at 12:20:19AM +0930, Andrew Jeffery wrote:
> > 
> > The patch introducing the g4 pinctrl driver implemented a smattering of
> > pins to flesh out the implementation of the core and provide bare-bones
> > support for some OpenPOWER platforms. Now, update the bindings document
> > to reflect the complete functionality and implement the necessary pin
> > configuration tables in the driver.
> We prefer bindings to be complete if possible where as drivers can be?
> expanded over time.

Noted.

> 
> > 
> > 
> > Cc: Timothy Pearson <tpearson@raptorengineering.com>
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> > ?Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt |???19 +-
> Acked-by: Rob Herring <robh@kernel.org>

Thanks,

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161004/746c8627/attachment.sig>
