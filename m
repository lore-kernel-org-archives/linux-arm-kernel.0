From: tony@atomide.com (Tony Lindgren)
Date: Mon, 26 Aug 2013 04:18:14 -0700
Subject: [GIT PULL] ARM: OMAP: DRA7xx PRCM/hwmod support
In-Reply-To: <alpine.DEB.2.02.1308231909020.22768@utopia.booyaka.com>
References: <alpine.DEB.2.02.1308231909020.22768@utopia.booyaka.com>
Message-ID: <20130826111814.GE7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [130823 12:17]:
> Hi Tony
> 
> The following changes since commit cf470a1b1a741bca00080ebc70968b4f22d9b1ea:
> 
>   Merge tag 'dra7-core-support-minus-dt' of git://github.com/rrnayak/linux into omap-for-v3.12/soc (2013-08-14 01:01:41 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.12/dra7xx
> 
> for you to fetch changes up to 7de516a63c634a0db1920757f501f98f68f92716:
> 
>   ARM: OMAP: DRA7: Enable PM framework initializations (2013-08-23 04:29:37 -0600)
> 
> ----------------------------------------------------------------
> This series adds basic TI DRA7xx PRCM and hwmod support.
> 
> Basic test logs are available here:
> 
> http://www.pwsan.com/omap/testlogs/dra7xx_prcm_devel_v3.12/20130823050445/
> 
> Note that DRA7xx could not be tested locally, since I don't have a board.

Thanks, pulling into omap-for-v3.12/soc. As it's this late in the merge
window, these may not get merged for v3.12, but lets' see. I'll run
make randconfig on these for a while and send out the remaining pull
requests today.

Regards,

Tony
