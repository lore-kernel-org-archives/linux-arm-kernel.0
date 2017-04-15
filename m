From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 15 Apr 2017 15:54:54 +0200 (CEST)
Subject: [PATCH] irqchip/irq-imx-gpcv2: fix spinlock initialization
In-Reply-To: <87bmrxpz58.fsf@on-the-bus.cambridge.arm.com>
References: <20170413222731.5917-1-tyler.baker@linaro.org>
 <87bmrxpz58.fsf@on-the-bus.cambridge.arm.com>
Message-ID: <alpine.DEB.2.20.1704151554220.2327@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 15 Apr 2017, Marc Zyngier wrote:
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Thomas, any chance you could take this as a fix through the tip tree?

It's in Linus tree already :)
