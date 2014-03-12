From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 12 Mar 2014 13:37:59 +0100
Subject: [PATCH 2/2] ARM: dts: berlin2q: add the Marvell BG2-Q DMP device
 tree
In-Reply-To: <20140312200428.23178d69@xhacker>
References: <1394622364-6848-1-git-send-email-antoine.tenart@free-electrons.com>
 <1394622364-6848-3-git-send-email-antoine.tenart@free-electrons.com>
 <20140312200428.23178d69@xhacker>
Message-ID: <20140312123759.GB15090@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +/dts-v1/;
> > +#include "berlin2q.dtsi"
> > +
> > +/ {
> > +	model = "Marvell BG2-Q DMP";
> > +	compatible = "marvell,berlin2q-dmp", "marvell,berlin2q",
> > "marvell,berlin"; +
> > +	memory {
> > +		device_type = "memory";
> > +		reg = <0x00000000 0x40000000>;
> 
> The memory size of BG2Q DMP is 2GB.

Jisheng

Does this imply that the RAM is inside the SoC package, and that
there is no external memory interface which can be used to add more
RAM?

	Thanks
		Andrew
