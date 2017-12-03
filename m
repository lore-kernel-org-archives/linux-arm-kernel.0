From: olof@lixom.net (Olof Johansson)
Date: Sat, 2 Dec 2017 16:49:13 -0800
Subject: [PATCH 3/6] arm: dts: marvell: Add missing #phy-cells to
 usb-nop-xceiv
In-Reply-To: <20171121205622.GE30040@lunn.ch>
References: <20171109222614.5719-1-robh@kernel.org>
 <20171109222614.5719-3-robh@kernel.org>
 <20171121205622.GE30040@lunn.ch>
Message-ID: <20171203004913.6oqng6uqpbspfvzm@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 21, 2017 at 09:56:22PM +0100, Andrew Lunn wrote:
> On Thu, Nov 09, 2017 at 04:26:11PM -0600, Rob Herring wrote:
> > "usb-nop-xceiv" is using the phy binding, but is missing #phy-cells
> > property. This is probably because the binding was the precursor to the phy
> > binding.
> > 
> > Fixes the following warning in Marvell dts files:
> > 
> > Warning (phys_property): Missing property '#phy-cells' in node ...
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

I didn't see this come in before -rc1 and in current fixes, so given the acks
I've applied it directly now.


-Olof
