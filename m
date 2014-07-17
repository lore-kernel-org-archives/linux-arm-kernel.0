From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 17 Jul 2014 08:51:31 -0400
Subject: [PATCH 0/4 V3] irqchip: gic: Introduce ARM GICv2m MSI(-X) support
In-Reply-To: <53C3FE7D.3090805@amd.com>
References: <1404947104-21345-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20140713231431.GM13108@titan.lakedaemon.net>
 <53C3FE7D.3090805@amd.com>
Message-ID: <20140717125131.GJ13108@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 10:59:57AM -0500, Suravee Suthikulanit wrote:
> On 7/13/2014 6:14 PM, Jason Cooper wrote:
> >Suravee,
> >
> >On Wed, Jul 09, 2014 at 06:05:00PM -0500, suravee.suthikulpanit at amd.com wrote:
> >>From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> >>
> >>This patch set introduces support for MSI(-X) in GICv2m specification,
> >>which is implemented in some variation of GIC400.
> >>
> >>This depends on and has been tested with the V7 of"Add support for PCI in AArch64"
> >>(https://lkml.org/lkml/2014/3/14/320).
> >
> >Grrr.  I mis-spoke against your v1 of this series.  There are more
> >changes to irq-gic.c than I originally thought in this series.
> 
> I am not quite sure what your are referring to.
> 

No problem, it was an old comment.  If you weren't depending on it then it
doesn't matter. ;-)

> >Additionally, we have a lot of other significant changes to that driver
> >as well this cycle.  It would be really helpful if I could take patches
> >1-3 through irqchip/gic.  I can Ack #4 with the Subject change, and the
> >branch it lands in can depend on irqchip/gic, no problem there.
> 
> Patch 1-3 should be able to go through the irqchip/gic along with
> the gicv3 from Marc, which I have rebased this patch against.

Perfect!

> Patch 4 is arch64 architectural changes.  Therefore, it might need
> to be going through a different branch. Marc/Mark/Will/Catalin, do
> you have any suggestions on which branch this should go to?

Yep, I'll Ack it for arm64 to take, conflicts should be minimal.

thx,

Jason.
