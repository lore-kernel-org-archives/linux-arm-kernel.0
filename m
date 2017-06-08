From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 8 Jun 2017 14:10:23 +0200
Subject: [PATCH v2 1/6] dt-bindings: interrupt-controller: add DT
 binding for the Marvell GICP
In-Reply-To: <20170607222420.perbnsnmizhyl42f@rob-hp-laptop>
References: <1496398017-6487-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1496398017-6487-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170607222420.perbnsnmizhyl42f@rob-hp-laptop>
Message-ID: <20170608141023.37759527@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 7 Jun 2017 17:24:20 -0500, Rob Herring wrote:
> On Fri, Jun 02, 2017 at 12:06:52PM +0200, Thomas Petazzoni wrote:
> > This commit adds the Device Tree binding documentation for the Marvell
> > GICP, an extension to the GIC that allows to trigger GIC SPI interrupts
> > using memory transactions. It is used by the ICU unit in the Marvell
> > CP110 block to turn wired interrupts inside the CP into SPI interrupts
> > at the GIC level in the AP.  
> 
> Sounds like an MSI block?

Marc Zyngier answered on this (much better than I could have done).

> > +- marvell,spi-ranges: tuples of GIC SPI interrupts ranges available
> > +  for this GICP  
> 
> These are base+size?

Correct. Does your question suggest that I should update the binding
document to make this explicit?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
