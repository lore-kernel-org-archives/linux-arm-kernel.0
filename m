From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Dec 2015 20:21:31 +0100
Subject: [PATCH v5 2/2] arm: pxa27x: support for ICP DAS LP-8x4x w/ DT
In-Reply-To: <1450205413.21989.44.camel@gmail.com>
References: <1449700088-28076-3-git-send-email-ynvich@gmail.com>
 <87a8pbio2u.fsf@belgarion.home> <1450205413.21989.44.camel@gmail.com>
Message-ID: <4511402.o53nMsg37l@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 December 2015 21:50:13 Sergei Ianovich wrote:
> On Tue, 2015-12-15 at 19:06 +0100, Robert Jarzmik wrote:


> > > 4. all optional pxa stuff as modules
> > > 5. all stuff on supported pxa boards as modules
> > 
> > > If #5 is extended when support for new boards is added, it should be
> > > possible to run any supported pxa27x board with pxa27x_defconfig.
> > 
> > I'm very eager to see a patch on that. I can feed my Jenkins with it,
> > it would
> > greatly help me catch issues earlier. Moreover it would for free test
> > it on
> > lubbock, mainstone and mioa701. If there was one also for pxa3xx, I
> > would launch
> > it on zylonite cm-x300 ... (that's a bonus, I know :))
> > 
> 
> Updated plan:
> 1. MACH_PXA27X_DT
> 2. PXA_FB and 8250_PXA to enable console
> 3. MMC, MMC_PXA and EXT4_FS to enable boot from MMC
> 3.1. MTD, MTD_CFI, MTD_PHYSMAP_OF and JFFS2_FS to enable boot from MTD
> 4. all optional pxa stuff as modules
> 5. all stuff on supported pxa boards as modules
> 6. supported boards should boot the kernel built with
> `pxa27x-dt_defconfig` after `make olddefconfig`
> 
> It is probably a good idea to put this plan somewhere in Documentation/
> and to have a comment about that in the defconfig itself.
> 
> Is the plan acceptable?

Sounds good to me.

	Arnd
