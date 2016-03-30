From: tony@atomide.com (Tony Lindgren)
Date: Wed, 30 Mar 2016 10:39:02 -0700
Subject: [GIT PULL] ARM: OMAP2+: first hwmod fix for v4.6-rc
In-Reply-To: <alpine.DEB.2.02.1603290647170.20409@utopia.booyaka.com>
References: <alpine.DEB.2.02.1603290647170.20409@utopia.booyaka.com>
Message-ID: <20160330173901.GV9329@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [160328 23:49]:
> Hi Tony
> 
> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> 
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.6-rc/omap-fixes-a
> 
> for you to fetch changes up to 3ca4a238106dedc285193ee47f494a6584b6fd2f:
> 
>   ARM: OMAP2+: hwmod: Fix updating of sysconfig register (2016-03-26 23:08:55 -0600)
> 
> ----------------------------------------------------------------
> ARM: OMAP2+: first hwmod fix for v4.6-rc
> 
> Fix a longstanding bug in the hwmod code that could cause
> hardware SYSCONFIG register values to not match the kernel's
> idea of what they should be, and that could result in lower
> performance during IP block idle entry.

Pulling into omap-for-v4.6/fixes thanks.

Tony
