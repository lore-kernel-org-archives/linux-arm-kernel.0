From: tony@atomide.com (Tony Lindgren)
Date: Tue, 29 Jul 2014 04:04:50 -0700
Subject: [GIT PULL] ARM: OMAP2+: PLL rounding change for v3.17
In-Reply-To: <alpine.DEB.2.02.1407251254540.18958@utopia.booyaka.com>
References: <alpine.DEB.2.02.1407251254540.18958@utopia.booyaka.com>
Message-ID: <20140729110449.GM29045@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [140725 05:58]:
> Hi Tony
> 
> The following changes since commit a497c3ba1d97fc69c1e78e7b96435ba8c2cb42ee:
> 
>   Linux 3.16-rc2 (2014-06-21 19:02:54 -1000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.17/omap-clock-b
> 
> for you to fetch changes up to 0a26344440b5f9940c99112fdc3804f073b1f5a7:
> 
>   ARM: OMAP2+: clock: allow omap2_dpll_round_rate() to round to next-lowest rate (2014-07-25 06:11:15 -0600)
> 
> ----------------------------------------------------------------
> Modify OMAP PLL rate rounding function to round to the exact rate requested
> or the next one below it.  This is intended to resolve some DSS problems.
> 
> Basic build, boot, and PM test results are available here:
> 
> http://www.pwsan.com/omap/testlogs/clock-b-v3.17/20140725061121/

Pulling into omap-for-v3.17/soc thanks.

Tony
