From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 5 Jul 2016 18:03:38 +0000
Subject: [GIT PULL 3/3] bcm2835-arm64-next-2016-07-03
In-Reply-To: <1467593136-29524-4-git-send-email-eric@anholt.net>
References: <1467593136-29524-1-git-send-email-eric@anholt.net>
 <1467593136-29524-4-git-send-email-eric@anholt.net>
Message-ID: <20160705180338.GI3348@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric,

On Sun, Jul 03, 2016 at 05:45:36PM -0700, Eric Anholt wrote:
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/anholt/linux tags/bcm2835-arm64-next-2016-07-03
> 
> for you to fetch changes up to 628d30d1ccb897fee54a6f7312561cf2f6f72f09:
> 
>   arm64: Add platform selection for BCM2835. (2016-06-15 14:10:30 -0700)
> 
> ----------------------------------------------------------------
> This pull request brings in the build support for the Raspberry Pi
> arm64 port.
> 
> ----------------------------------------------------------------
> Alexander Graf (1):
>       arm64: Allow for different DMA and CPU bus offsets
> 
> Eric Anholt (3):
>       irqchip: bcm2835: Avoid arch/arm-specific handle_IRQ
>       Merge remote-tracking branch 'irqchip/irqchip/bcm' into bcm2835-arm64-next

You may want to draw attention to the fact that this has an external
dependency on my irqchip/bcm branch.  Also, that it's stable, been in
-next for a couple of weeks, and based on v4.7-rc1, etc.

thx,

Jason.

>       arm64: Add platform selection for BCM2835.
> 
>  arch/arm64/Kconfig.platforms         | 13 +++++++++++++
>  arch/arm64/include/asm/dma-mapping.h | 17 +++++++++++++++--
>  drivers/irqchip/irq-bcm2835.c        |  3 +--
>  drivers/irqchip/irq-bcm2836.c        |  2 +-
>  4 files changed, 30 insertions(+), 5 deletions(-)
