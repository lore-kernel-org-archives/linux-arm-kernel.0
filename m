From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 12 Dec 2013 15:48:16 -0500
Subject: [PATCH v2] MAINTAINERS: Add DesignWare, i.MX6, Armada, R-Car
 PCI host maintainers
In-Reply-To: <20131212204610.GK4699@google.com>
References: <20131211183237.GI4699@google.com>
 <20131212204610.GK4699@google.com>
Message-ID: <20131212204816.GA2609@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 01:46:10PM -0700, Bjorn Helgaas wrote:
> [+cc Thomas]
> 
> On Wed, Dec 11, 2013 at 11:32:37AM -0700, Bjorn Helgaas wrote:
> > If this looks reasonable, I'll merge it via the PCI tree for v3.13.
> 
> OK, here's another try.  I'm not actually trying to nominate anybody; I
> just tried to write down the list we came up with in an earlier discussion [1].
> 
> I'd like confirmation from the following people that they approve of being
> listed here:
> 
>   Richard Zhu (IMX6)
>   Thomas Petazzoni (MVEBU)
>   Magnus Damm (R-CAR)
> 
> I think everybody else listed has already said they approve.
> 
> [1] http://lkml.kernel.org/r/CAErSpo5tN==4nSv2u3SUBe_L4VsWn4P7TN+LtrC172Qj1vhtog at mail.gmail.com
> 
> 
> MAINTAINERS: Add DesignWare, i.MX6, Armada, R-Car PCI host maintainers
> 
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Add entries for PCI host controller drivers in drivers/pci/host/.
> 
> Signed-off-by: Mohit Kumar <mohit.kumar@st.com>		(DesignWare)
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>	(DesignWare)
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>	(R-CAR)
> Acked-by: Jason Cooper <jason@lakedaemon.net>		(MVEBU)

If Thomas is ok with it:

Double-Plus-Acked-by: Jason Cooper <jason@lakedaemon.net>

for the mvebu bits.

thx,

Jason.
