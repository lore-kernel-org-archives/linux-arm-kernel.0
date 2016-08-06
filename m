From: tony@atomide.com (Tony Lindgren)
Date: Fri, 5 Aug 2016 23:26:02 -0700
Subject: [PATCH 0/2] Drop last two remaining omap3 legacy board files
In-Reply-To: <20160805174557.GA27448@earth>
References: <1465987689-14812-1-git-send-email-tony@atomide.com>
 <20160805174557.GA27448@earth>
Message-ID: <20160806062601.GM28140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Reichel <sre@kernel.org> [160805 10:46]:
> Hi Tony,
> 
> On Wed, Jun 15, 2016 at 03:48:07AM -0700, Tony Lindgren wrote:
> > Here are two patches to drop the last remaining omap3 legacy boot
> > files. We have device tree based booting working for these boards,
> > and the legacy booting has been mostly kept around to validate
> > against regressions.
> > 
> > Let's not touch the rest of the platform init code until around
> > v4.9 so we can revert these two patches if needed.
> >
> > Cheers,
> > 
> > Tony
> > 
> > Tony Lindgren (2):
> >   ARM: OMAP2+: Drop legacy board file for n900
> >   ARM: OMAP2+: Drop legacy board file for LDP
> 
> I wonder what happened to these patches. I see, that you have a
> omap-for-v4.8/legacy branch, which contains them. But as far as I
> can see its not in linux-next and it was not included in the ARM
> pull request.

Well I took some time off and wanted to see v4.8-rc1 work with
legacy mode as we have it in few automated test systems.
So I did not add them to Linux next yet. My plan is to
send them right after v4.8-rc1 and wait on any further legacy
code removal until v4.9.

Regards,

Tony
