From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 1 Nov 2014 21:59:36 -0400
Subject: [PATCH] irqchip: hip04: Convert to handle_domain_irq
In-Reply-To: <1413882576-18922-1-git-send-email-marc.zyngier@arm.com>
References: <1413882576-18922-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20141102015936.GP3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 21, 2014 at 10:09:36AM +0100, Marc Zyngier wrote:
> The HIP04 GIC-like irqchip escaped the conversion to handle_domain_irq.
> Let's give it the treatment it deserves.
> 
> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/irqchip/irq-hip04.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to irqchip/core

thx,

Jason.
