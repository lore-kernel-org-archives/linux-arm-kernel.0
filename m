From: balbi@ti.com (Felipe Balbi)
Date: Fri, 8 Jul 2011 14:58:43 +0300
Subject: [PATCH 1/3] ARM: OMAP4: Add pcm049 to Kconfig/Makefile
In-Reply-To: <20110708115521.GA5783@atomide.com>
References: <1310119464-3514-1-git-send-email-j.weitzel@phytec.de>
	<1310119464-3514-2-git-send-email-j.weitzel@phytec.de>
	<4E16EECF.7030102@mvista.com> <20110708115521.GA5783@atomide.com>
Message-ID: <20110708115842.GJ4820@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Fri, Jul 08, 2011 at 04:55:21AM -0700, Tony Lindgren wrote:
> * Sergei Shtylyov <sshtylyov@mvista.com> [110708 04:45]:
> > Hello.
> > 
> > On 08-07-2011 14:04, Jan Weitzel wrote:
> > 
> > >Signed-off-by: Jan Weitzel<j.weitzel@phytec.de>
> > >---
> > >  arch/arm/mach-omap2/Kconfig  |    5 +++++
> > >  arch/arm/mach-omap2/Makefile |    4 ++++
> > >  2 files changed, 9 insertions(+), 0 deletions(-)
> > 
> > >diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > >index 19d5891..c6a2d43 100644
> > >--- a/arch/arm/mach-omap2/Kconfig
> > >+++ b/arch/arm/mach-omap2/Kconfig
> > [...]
> > >diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> > >index b148077..e81b594 100644
> > >--- a/arch/arm/mach-omap2/Makefile
> > >+++ b/arch/arm/mach-omap2/Makefile
> > >@@ -238,6 +238,10 @@ obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-omap4panda.o \
> > >  					   hsmmc.o \
> > >  					   omap_phy_internal.o
> > >
> > >+obj-$(CONFIG_MACH_PCM049)		+= board-omap4pcm049.o \
> > 
> >    You need to first add board-omap4pcm049.c, and only then wire it
> > to the Makefile. You could do both in onme patch though...
> 
> Yes looks like this should be just one patch for everything.

Are you or are you not taking now board files ? We have one which was
left out due to a comment from Russell stating that no new board-files
would be accepted until the move to device tree was completed [1]

[1] http://marc.info/?t=130199607500006&r=1&w=2

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110708/91a2ee02/attachment.sig>
