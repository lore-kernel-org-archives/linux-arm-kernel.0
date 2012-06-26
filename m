From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 26 Jun 2012 12:21:20 +0200
Subject: [PATCH v4 3/9] arm: mach-mvebu: add source files
In-Reply-To: <4FE98981.40903@free-electrons.com>
References: <1340699313-29331-1-git-send-email-gregory.clement@free-electrons.com>
 <1340699313-29331-4-git-send-email-gregory.clement@free-electrons.com>
 <20120626084715.GC25625@lunn.ch>
 <4FE98981.40903@free-electrons.com>
Message-ID: <20120626102120.GG25625@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 12:05:53PM +0200, Gregory CLEMENT wrote:
> On 06/26/2012 10:47 AM, Andrew Lunn wrote:>> +#define ARMADA_370_XP_RESET_OFFSET		  0x60
> >> +#define OTHER_MVEBU_RESET_OFFSET		 0x108
> >> +#define MVEBU_RSTOUTN_MASK_OFFSET		   0x0
> >> +#define   OTHER_MVEBU_RSTOUTN_MASK_RESET_OUT_EN	   0x4
> >> +#define   ARMADA_370_XP_RSTOUTN_MASK_RESET_OUT_EN  0x1
> >> +#define MVEBU_SYSTEM_SOFT_RESET_OFFSET		   0x4
> >> +#define   MVEBU_SYSTEM_SOFT_RESET		   0x1
> >> +
> >> +#define OTHER_MVEBU_VARIANT	1
> >> +#define ARMADA_370_XP_VARIANT	2
> >
> > Hi Gregory
> >
> 
> Hi Andrew,
> 
> > Rather than OTHER, could you call this ORION?
> >
> 
> I thought that one purpose of the next mach-mvebu directory, was to
> remove the references to orion.
> 
> However, I agree that OTHER is not a really good name. We could
> consider indeed 'orion' as a legacy name for this subset of' mvebu'.

Well, Orion is well known to describe this subset. If we want to
remove the use of Orion we need a different naming scheme. We could
use V1 for Orion, and V2 for ARMADA 370 XP. 

For me, using orion and armada-370-xp is more informative.

    Andrew
