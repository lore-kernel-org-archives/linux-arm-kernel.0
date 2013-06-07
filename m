From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Jun 2013 15:06:37 -0700
Subject: [GIT PULL] ARM: OMAP: hwmod/clock: more fixes for v3.10-rc
In-Reply-To: <alpine.DEB.2.02.1306061746150.5152@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306061746150.5152@utopia.booyaka.com>
Message-ID: <20130607220636.GN3331@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [130606 10:54]:
> Hi Tony
> 
> The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:
> 
>   Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-fixes-b-for-3.10-rc
> 
> for you to fetch changes up to a93d8a1cea0899982993e9a93404c6f78b123697:
> 
>   ARM: omap3: clock: fix wrong container_of in clock36xx.c (2013-06-06 08:48:07 -0600)
> 
> ----------------------------------------------------------------
> More OMAP hwmod and clock fixes for v3.10-rc.  Fixes the AM33xx UART2.
> Also fixes some CCF-related breakage on OMAP36xx/37xx, affecting DSS
> at the very least.
> 
> Basic test logs for this branch are here:
> 
> http://www.pwsan.com/omap/testlogs/fixes_b_v3.10-rc/20130606093449/

Thanks pulling into omap-for-v3.10/fixes.

Tony
