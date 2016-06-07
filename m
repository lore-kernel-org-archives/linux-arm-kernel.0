From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 7 Jun 2016 12:41:59 +0000
Subject: [PATCH v3 02/10] irqchip: bcm2835: Avoid arch/arm-specific
 handle_IRQ.
In-Reply-To: <1465297548-17182-3-git-send-email-kraxel@redhat.com>
References: <1465297548-17182-1-git-send-email-kraxel@redhat.com>
 <1465297548-17182-3-git-send-email-kraxel@redhat.com>
Message-ID: <20160607124159.GD24391@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gerd,

On Tue, Jun 07, 2016 at 01:05:40PM +0200, Gerd Hoffmann wrote:
> From: Eric Anholt <eric@anholt.net>
> 
> This is equivalent and works for arm64 as well.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/irqchip/irq-bcm2835.c | 3 +--
>  drivers/irqchip/irq-bcm2836.c | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)

Please drop this from your series, it's already applied.

thx,

Jason.
