From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Oct 2010 11:40:17 -0700
Subject: [PATCH 00/10] OMAP: SCM/McBSP/clock: branch integration
	patches for 2.6.37
In-Reply-To: <20101005155242.20900538.jhnikula@gmail.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
	<20101005155242.20900538.jhnikula@gmail.com>
Message-ID: <20101005184017.GP3117@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jarkko Nikula <jhnikula@gmail.com> [101005 05:43]:
> On Fri, 01 Oct 2010 15:34:45 -0600
> Paul Walmsley <paul@pwsan.com> wrote:
> 
> > mach-omap2 (as the SCM only exists on OMAP2+ systems).  The McBSP
> > parent fclk and signal muxing changes have received only light
> > testing, so any help from OMAP ASoc experts here is appreciated.
> > 
> Looks good to me. I pointed out one bug but as these are already in
> linux-omap I sent a fix for it and two minor cleanups [1].
> 
> > Paul Walmsley (10):
> >       OMAP2+: Kconfig: disallow builds for boards that don't use the currently-selected SoC
> >       OMAP2420: CTRL: fix OMAP242X_CTRL_REGADDR macro
> >       OMAP2420: clock: add MCBSP_CLKS node and clkdev aliases
> >       OMAP2430: clock: add MCBSP_CLKS node and clkdev aliases
> >       OMAP3xxx: clock: add clkdev aliases for McBSP fclk source switching
> >       OMAP: McBSP: implement McBSP CLKR and FSR signal muxing via mach-omap2/mcbsp.c
> >       OMAP: McBSP: implement functional clock switching via clock framework
> >       OMAP: split plat-omap/common.c
> >       OMAP: control: move plat-omap/control.h to mach-omap2/control.h
> >       OMAP2+: clock: reduce the amount of standard debugging while disabling unused clocks
> > 
> Patches 3-5 are doing the right thing AFAIK the OMAP clock framework.
> 
> For patches 6-7 you could have my ack.
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>
> 
> As they are touching also sound/soc/omap/omap-mcbsp.c, an ack from Mark
> and Liam are needed. Links to patches 6 and 7 below and my fixes on top
> of them [1].
> 
> http://marc.info/?l=linux-omap&m=128596931117788&w=2
> http://marc.info/?l=linux-omap&m=128596931417805&w=2

Sorry, I've already merged them as they fixed code that did not compile.

Let me know if you guys want me to rebuild those parts of omap-for-linus
to add the acks.

Tony
