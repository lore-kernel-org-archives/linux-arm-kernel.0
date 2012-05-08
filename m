From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 May 2012 14:56:31 -0700
Subject: [PATCH v2] ARM: OMAP: WiLink platform data for the PandaBoard
In-Reply-To: <4F648A3B.7020003@gmail.com>
References: <1331074504-22683-1-git-send-email-mgherzan@gmail.com>
 <4F648A3B.7020003@gmail.com>
Message-ID: <20120508215629.GI5088@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mircea Gherzan <mgherzan@gmail.com> [120317 06:00]:
> Hi Tony,
> 
> Am 06.03.2012 23:55, schrieb Mircea Gherzan:
> > The "uim" deamon requires sysfs entries that are filled in using
> > this platform data.
> > 
> > Signed-off-by: Mircea Gherzan <mgherzan@gmail.com>
> > ---
> >  arch/arm/mach-omap2/board-omap4panda.c |   14 ++++++++++++--
> >  include/linux/ti_wilink_st.h           |    2 ++
> >  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> Gentle ping.

Thanks for patience, applying to board branch finally.

Tony
