From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 5 Mar 2014 17:12:12 +0800
Subject: [PATCH 1/4] phy: miphy365x: Add Device Tree bindings for the
 MiPHY365x
In-Reply-To: <20140305084039.GB14902@lee--X1>
References: <1392377036-12816-1-git-send-email-lee.jones@linaro.org>
 <20140305073422.GD20016@e106331-lin.cambridge.arm.com>
 <20140305084039.GB14902@lee--X1>
Message-ID: <20140305091212.GA10380@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > +Specifying phy control of devices
> > > +=================================
> > > +
> > > +Device nodes should specify the configuration required in their "phys"
> > > +property, containing a phandle to the miphy device node, a port number
> > > +and a device type.
> > > +
> > > +Example:
> > > +
> > > +#include <dt-bindings/phy/phy-miphy365x.h>
> > > +
> > > +	sata0: sata at fe380000 {
> > > +		...
> > > +		phys	  = <&miphy365x_phy MIPHY_PORT_0 MIPHY_TYPE_SATA>;
> > > +		...
> > > +	};
> > 
> > Is there not a generic phy binding we can point to? It seems a bit
> > redundant to do this in each phy binding.
> 
> Sure, but that wouldn't make much of an example.
> 
>   Documentation/devicetree/bindings/phy/phy-bindings.txt

Ah sorry, I see what you mean now.

No, not yet. That's the next thing to go up into Mainline.

I will replace this second example with a link when the other
documentation document has been accepted.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
