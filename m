From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Jul 2014 18:56:20 -0400
Subject: [PATCH] irqchip: gic: Add support for cortex a7 compatible string
In-Reply-To: <1404388732-28890-1-git-send-email-matthias.bgg@gmail.com>
References: <1404388732-28890-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <20140708225620.GL13433@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 01:58:52PM +0200, Matthias Brugger wrote:
> Patch 0a68214b "ARM: DT: Add binding for GIC virtualization extentions (VGIC)" added
> the "arm,cortex-a7-gic" compatible string, but the corresponding IRQCHIP_DECLARE
> was never added to the gic driver.
> 
> To let real Cortex-A7 SoCs use it, add the necessary declaration to the device driver.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/irqchip/irq-gic.c |    1 +
>  1 file changed, 1 insertion(+)

Applied to irqchip/urgent and Cc'd to stable for v3.5+

thx,

Jason.
