From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 1 Nov 2014 22:23:11 -0400
Subject: [PATCH v2] irqchip: dw-apb-ictl: select GENERIC_IRQ_CHIP
In-Reply-To: <1413982750-832-1-git-send-email-jszhang@marvell.com>
References: <1413982750-832-1-git-send-email-jszhang@marvell.com>
Message-ID: <20141102022311.GS3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jisheng,

On Wed, Oct 22, 2014 at 08:59:10PM +0800, Jisheng Zhang wrote:
> The dw-apb-ictl driver uses the generic-chip functions.
> Thus it needs to select GENERIC_IRQ_CHIP in Kconfig.
> 
> Change-Id: If748beffc4e0d0b47062bb067a59c10994a9148b

Please don't include this is future patches.

> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/irqchip/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied to irqchip/core

thx,

Jason.
