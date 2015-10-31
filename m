From: olof@lixom.net (Olof Johansson)
Date: Sat, 31 Oct 2015 01:42:22 +0000
Subject: [GIT PULL] two omap regression fixes for v4.3-rc cycle
In-Reply-To: <20151029201829.GF3078@atomide.com>
References: <20151029201829.GF3078@atomide.com>
Message-ID: <20151031014222.GB1722@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 01:18:30PM -0700, Tony Lindgren wrote:
> The following changes since commit 57df5380853460bc66b59a46273ce113c923d39c:
> 
>   ARM: OMAP2+: Fix imprecise external abort caused by bogus SRAM init (2015-10-19 08:55:46 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/fixes-rc7
> 
> for you to fetch changes up to 8f2279d5d908119a08e906be1c6b69c744d0c379:
> 
>   usb: musb: omap2430: Fix regression caused by driver core change (2015-10-28 10:16:04 -0700)
> 
> ----------------------------------------------------------------
> Two omap regression fixes:
> 
> - Fix omap3 MUSB with DMA caused by driver core changes
> 
> - Fix LCD DMA interrupt number for omap1 that did not
>   get changed for sparse IRQ changes
> 
> ----------------------------------------------------------------
> Aaro Koskinen (1):
>       ARM: OMAP1: fix incorrect INT_DMA_LCD
> 
> Tony Lindgren (1):
>       usb: musb: omap2430: Fix regression caused by driver core change
> 

Thanks, merged.


-Olof
