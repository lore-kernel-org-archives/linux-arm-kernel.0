From: nm@ti.com (Nishanth Menon)
Date: Tue, 12 Jun 2018 17:04:06 -0500
Subject: [RFC PATCH 5/8] dt-bindings: mailbox: ti,message-manager: Add
 support for secure proxy threads
In-Reply-To: <20180612211128.GA22038@rob-hp-laptop>
References: <20180605061629.4759-1-nm@ti.com> <20180605061629.4759-6-nm@ti.com>
 <20180612211128.GA22038@rob-hp-laptop>
Message-ID: <20180612220406.t4mkcht3ubwo3hej@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21:11-20180612, Rob Herring wrote:
[...]
> > diff --git a/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt b/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
> > index ebf0e3710cee..de796e90cac6 100644
> > --- a/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
> > +++ b/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
> > @@ -7,22 +7,40 @@ manager is broken up into queues in different address regions that are called
> >  "proxies" - each instance is unidirectional and is instantiated at SoC
> >  integration level to indicate receive or transmit path.
> >  
> > +This can also be used to describe Texas Instrument's Secure Proxy
> > +controller that allows for individually configurable "threads" or
> > +"proxies" which allow for independent communication scheme.
> 
> There seems to be very little re-use here. I think I would make this 
> its own doc.

Agreed. will do the same in the formal series. Thanks.
-- 
Regards,
Nishanth Menon
