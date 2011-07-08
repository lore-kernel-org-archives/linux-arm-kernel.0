From: tony@atomide.com (Tony Lindgren)
Date: Fri, 8 Jul 2011 04:55:21 -0700
Subject: [PATCH 1/3] ARM: OMAP4: Add pcm049 to Kconfig/Makefile
In-Reply-To: <4E16EECF.7030102@mvista.com>
References: <1310119464-3514-1-git-send-email-j.weitzel@phytec.de>
	<1310119464-3514-2-git-send-email-j.weitzel@phytec.de>
	<4E16EECF.7030102@mvista.com>
Message-ID: <20110708115521.GA5783@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sergei Shtylyov <sshtylyov@mvista.com> [110708 04:45]:
> Hello.
> 
> On 08-07-2011 14:04, Jan Weitzel wrote:
> 
> >Signed-off-by: Jan Weitzel<j.weitzel@phytec.de>
> >---
> >  arch/arm/mach-omap2/Kconfig  |    5 +++++
> >  arch/arm/mach-omap2/Makefile |    4 ++++
> >  2 files changed, 9 insertions(+), 0 deletions(-)
> 
> >diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> >index 19d5891..c6a2d43 100644
> >--- a/arch/arm/mach-omap2/Kconfig
> >+++ b/arch/arm/mach-omap2/Kconfig
> [...]
> >diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> >index b148077..e81b594 100644
> >--- a/arch/arm/mach-omap2/Makefile
> >+++ b/arch/arm/mach-omap2/Makefile
> >@@ -238,6 +238,10 @@ obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-omap4panda.o \
> >  					   hsmmc.o \
> >  					   omap_phy_internal.o
> >
> >+obj-$(CONFIG_MACH_PCM049)		+= board-omap4pcm049.o \
> 
>    You need to first add board-omap4pcm049.c, and only then wire it
> to the Makefile. You could do both in onme patch though...

Yes looks like this should be just one patch for everything.

Regards,

Tony
