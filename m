From: tony@atomide.com (Tony Lindgren)
Date: Wed, 11 Nov 2009 10:56:09 -0800
Subject: [PATCH 3/8] omap1: Amstrad Delta defconfig fixes
In-Reply-To: <200911111825.00281.jkrzyszt@tis.icnet.pl>
References: <20091111025907.31793.84134.stgit@localhost>
	<20091111030057.31793.60438.stgit@localhost>
	<200911111825.00281.jkrzyszt@tis.icnet.pl>
Message-ID: <20091111185609.GE24837@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091111 09:24]:
> Wednesday 11 November 2009 04:00:57 Tony Lindgren napisa?(a):
> > From: Janusz Krzysztofik <jkrzysz@tis.icnet.pl>
> >
> > The patch provides the following fixes:
> >
> > - keep kernel small enough to boot with standard tools,
> > - ensure compatibility with both new and legacy distros,
> > - turn on support for recently added or fixed hardware features.
> >
> > Created and tested against linux-2.6.32-rc5.
> >
> > Signed-off-by: Janusz Krzysztofik <jkrzysz@tis.icnet.pl>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Tony,
> 
> Please do not apply this patch yet, or revert it if already applied. It would 
> exhibit the LCD DMA not working bug when CONFIG_PM=y, as I tried to state 
> while submitting v2 of my fix that corrected the issue 
> (http://www.spinics.net/lists/linux-omap/msg19963.html).
> 
> Sorry for not stating that again with this submission (or not waiting with 
> the submission after the bug is fixed first). That happened after I 
> misinterpreted your comment "Sounds good to me."  
> (http://www.spinics.net/lists/linux-omap/msg19965.html) as your acceptance 
> for the patch v2 as posted, with my self proposed changes, that resulted in v3  
> submission directly (http://www.spinics.net/lists/linux-omap/msg20059.html), 
> that has been objected by you next.

OK, sorry looks like I forgot that issue..

I suggest we keep this patch, and also add your v3 patch before this one.

I'll post your v3 patch to this thread with an added comment about
moving the OMAP_LCDC_ defines during the next merge cycle.

Regards,

Tony
