From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Sat, 05 Dec 2015 08:49:49 +0100
Subject: [PATCH v3 0/10] cpufreq: add generic cpufreq driver support for
 Exynos542x/5800 platforms
In-Reply-To: <20151205035444.GR3430@ubuntu>
References: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
 <20151205035444.GR3430@ubuntu>
Message-ID: <3776700.7KBsWa2Q4V@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Saturday, December 05, 2015 09:24:44 AM Viresh Kumar wrote:
> On 04-12-15, 18:30, Bartlomiej Zolnierkiewicz wrote:
> > Hi,
> > 
> > This patch series adds generic arm_big_little_dt cpufreq driver
> > support for Exynos542x/5800 (using the new CPU clock type which
> > allows it).  It also:
> > - enhances arm_big_little[_dt] driver with CPU cluster regulator
> >   support
> > - adds CPU clock configuration data and CPU operating points
> >   setup for Exynos542x/5800
> > - adds CPU cluster regulator supplies for Exynos542x/5800 boards
> > 
> > This patch series has been tested on Exynos5422 based ODROID-XU3
> > Lite board.
> > 
> > Please note that this is not a final version of the patchset.
> > I just wanted to push out current work-in-progress patches that
> > integrate changes from Anand, Ben and me.
> 
> What's going on guys, Ben tried exactly same thing few days back:
> 
> http://marc.info/?l=linux-kernel&m=144909193925508&w=2

Why I appreciate Ben's work this not exactly the same thing as
the above patchset lacks critical CLK_RECALC_NEW_RATES bugfix and
few other minor fixes.

> And the comments given there applies to you as well.

Yes, sure.  That's why I wrote that this is work-in-progress
and put the TODO in the cover letter.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
