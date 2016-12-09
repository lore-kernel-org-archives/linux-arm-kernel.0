From: andrew@aj.id.au (Andrew Jeffery)
Date: Sat, 10 Dec 2016 09:25:15 +1030
Subject: [PATCH v3 2/6] mfd: dt: ranges, #address-cells and #size-cells
 as optional properties
In-Reply-To: <20161209224927.3indhfdjgyndtjid@rob-hp-laptop>
References: <20161206025321.1792-1-andrew@aj.id.au>
 <20161206025321.1792-3-andrew@aj.id.au>
 <20161209224927.3indhfdjgyndtjid@rob-hp-laptop>
Message-ID: <1481324115.3112.8.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-12-09 at 16:49 -0600, Rob Herring wrote:
> On Tue, Dec 06, 2016 at 01:53:17PM +1100, Andrew Jeffery wrote:
> > Whilst describing a device and not a bus, simple-mfd is modelled on
> > simple-bus where child nodes are iterated and registered as platform
> > devices. Some complex devices, e.g. the Aspeed LPC controller, can
> > benefit from address space mapping such that child nodes can use the
> > regs property to describe their resources within the multi-function
> > device.
> > 
> > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> > ?Documentation/devicetree/bindings/mfd/mfd.txt | 10 ++++++++++
> > ?1 file changed, 10 insertions(+)
> 
> No objections to this, but this is all implied by having a reg property.

Thanks for clarifying. I wasn't sure so I wrote the patch with the
thought that we could drop it if it wasn't necessary. Regardless, I
think being explicit about the properties is nice.

> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks,

Andrew

> 
> Rob
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161210/2a6b2791/attachment.sig>
