From: robh@kernel.org (Rob Herring)
Date: Fri, 9 Dec 2016 16:49:27 -0600
Subject: [PATCH v3 2/6] mfd: dt: ranges, #address-cells and #size-cells
 as optional properties
In-Reply-To: <20161206025321.1792-3-andrew@aj.id.au>
References: <20161206025321.1792-1-andrew@aj.id.au>
 <20161206025321.1792-3-andrew@aj.id.au>
Message-ID: <20161209224927.3indhfdjgyndtjid@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 01:53:17PM +1100, Andrew Jeffery wrote:
> Whilst describing a device and not a bus, simple-mfd is modelled on
> simple-bus where child nodes are iterated and registered as platform
> devices. Some complex devices, e.g. the Aspeed LPC controller, can
> benefit from address space mapping such that child nodes can use the
> regs property to describe their resources within the multi-function
> device.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  Documentation/devicetree/bindings/mfd/mfd.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)

No objections to this, but this is all implied by having a reg property.

Acked-by: Rob Herring <robh@kernel.org>

Rob
