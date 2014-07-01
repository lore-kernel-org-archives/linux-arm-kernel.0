From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Jul 2014 08:55:49 -0400
Subject: [PATCH 08/17] ARM: S5PC100: no more support S5PC100 SoC
In-Reply-To: <1404210076-2362-2-git-send-email-kgene.kim@samsung.com>
References: <1404210076-2362-1-git-send-email-kgene.kim@samsung.com>
 <1404210076-2362-2-git-send-email-kgene.kim@samsung.com>
Message-ID: <20140701125549.GG23978@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin,

On Tue, Jul 01, 2014 at 07:21:16PM +0900, Kukjin Kim wrote:
> This patch removes supporting codes for s5pc100 because no more used
> now.
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
...
>  drivers/irqchip/Kconfig                            |    1 -

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
