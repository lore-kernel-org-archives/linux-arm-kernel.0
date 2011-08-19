From: vinod.koul@intel.com (Koul, Vinod)
Date: Fri, 19 Aug 2011 18:23:46 +0530
Subject: [GIT PULL] dmaengine: at_hdmac fixes for next
In-Reply-To: <4E4A7713.1070902@atmel.com>
References: <4E4A7713.1070902@atmel.com>
Message-ID: <1313758426.2336.2.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-08-16 at 15:56 +0200, Nicolas Ferre wrote:
> Vinod,
> 
> Please pull from:
> 
>   git://github.com/at91linux/linux-2.6-at91.git nfe/sdma_at_hdmac
> 
> to receive latest updates for the Atmel at_hdmac dmaengine driver. Those changes are made on top of current linus' git tree (v3.1-rc2-59-g5bad33c).
> The patches below have been discussed on the linux-arm-kernel mailing-list.
> 
> Thanks,
> 
> Nicolas Ferre (4):
>       dmaengine: at_hdmac: replace spin_lock* with irqsave variants
>       dmaengine: at_hdmac: improve power management routines
>       dmaengine: at_hdmac: add wrappers for testing channel state
>       dmaengine: at_hdmac: fix way to specify cyclic capability
> 
>  drivers/dma/at_hdmac.c      |  159 +++++++++++++++++++++++++++++++++---------
>  drivers/dma/at_hdmac_regs.h |   24 +++++++
>  2 files changed, 149 insertions(+), 34 deletions(-)
> 
Hi Nicolas,

I tried to merge your branch, but I also get lot on unwanted commits :(
Looks like this branch is based on current Linus's tree, I typically
base my next on rc-X and not any random commit.

Either you can rebase to latest rc-X and I will merge, or since I
created a test branch I can extract your 4 patches and apply to my next.

Let me know which way you prefer


-- 
~Vinod
