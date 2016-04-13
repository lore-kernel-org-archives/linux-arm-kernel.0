From: tony@atomide.com (Tony Lindgren)
Date: Wed, 13 Apr 2016 12:32:43 -0700
Subject: [GIT PULL] ARM: OMAP2+: clockdomain: another fix for
 v4.6-rcync-mailbox><next-undeleted><enter-command>set editor='vim'
In-Reply-To: <alpine.DEB.2.02.1604130916040.9379@utopia.booyaka.com>
References: <alpine.DEB.2.02.1604130916040.9379@utopia.booyaka.com>
Message-ID: <20160413193243.GY5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [160413 02:17]:
> Hi Tony
> 
> The following changes since commit 3ca4a238106dedc285193ee47f494a6584b6fd2f:
> 
>   ARM: OMAP2+: hwmod: Fix updating of sysconfig register (2016-03-26 23:08:55 -0600)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.6-rc/omap-fixes-b
> 
> for you to fetch changes up to 1cbabcb9807e31e87ef3a12af76ea025ceb582d3:
> 
>   ARM: DRA7: clockdomain: Implement timer workaround for errata i874 (2016-04-10 11:43:57 -0600)
> 
> ----------------------------------------------------------------
> ARM: OMAP2+: clockdomain: another fix for v4.6-rc
> 
> For DRA7xx platforms, add a workaround for missed timer interrupts
> that appears to be due to an integration bug (erratum i874)
> 
> Basic build, boot, and PM test logs are available here:
> 
> http://www.pwsan.com/omap/testlogs/omap-fixes-b-for-v4.6-rc/20160413020850/
> 
> (The DRA7xx board here has not yet been added into the testbed.)

Pulling into omap-for-v4.6/fixes thanks.

Tony
