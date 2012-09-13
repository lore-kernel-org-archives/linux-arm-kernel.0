From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Sep 2012 22:04:04 -0700
Subject: [GIT PULL] ARM: OMAP2+: some Makefile cleanup for 3.7
In-Reply-To: <alpine.DEB.2.00.1209120911110.17903@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209120911110.17903@utopia.booyaka.com>
Message-ID: <20120913050403.GA4521@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120912 02:13]:
> Hi Tony,
> 
> The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:
> 
>   Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-cleanup-a-for-3.7
> 
> for you to fetch changes up to df47adb825c221ff45126fd54e531f01ea490334:
> 
>   ARM: OMAP2+: clean up PRCM sections of the Makefile (2012-09-11 19:09:15 -0600)
> 
> - Paul
> 
> ----------------------------------------------------------------
> Clean up and standardize several parts of
> arch/arm/mach-omap2/Makefile.  Beyond readability and diffstat
> improvements, the series should reduce the risk of conflicts during
> future cleanups by ensuring related lines are in the same section of the
> Makefile.

Thanks pulling into cleanup-makefile-sparse.

Regards,

Tony
