From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Jul 2015 21:15:52 -0700
Subject: [GIT PULL] ARM: OMAP2+: PRCM and hwmod changes for v4.3
In-Reply-To: <alpine.DEB.2.02.1507231456540.29543@utopia.booyaka.com>
References: <alpine.DEB.2.02.1507231456540.29543@utopia.booyaka.com>
Message-ID: <20150724041552.GE16878@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [150723 08:01]:
> Hi Tony,
> 
> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> 
>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.3/omap-hwmod-prcm-a
> 
> for you to fetch changes up to 3b86616e3058462c340710dc7a5ac34ec8453944:
> 
>   Merge branch 'prcm-a-for-v4.3' into hwmod-prcm-for-v4.3 (2015-07-23 08:49:57 -0600)
> 
> ----------------------------------------------------------------
> ARM: OMAP2+: PRCM and hwmod changes for v4.3
> 
> This series adds:
> 
> - I/O wakeup support for AM43xx
> - register lock and unlock support to the hwmod code (needed for the RTC
>   IP blocks on some chips)
> - several fixes for sparse warnings and an unnecessary null pointer test
> - a DRA7xx clockdomain configuration workaround, to deal with some hardware
>   bugs
> 
> Basic build, boot, and PM tests are here:
> 
> http://www.pwsan.com/omap/testlogs/hwmod-prcm-for-v4.3/20150723080012/
> 
> Since I do not have an AM43xx or DRA7xx device, I can't test on those
> platforms.

Thanks pulling into omap-for-v4.3/soc.

Regards,

Tony
