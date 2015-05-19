From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 19 May 2015 16:48:33 +0200 (CEST)
Subject: [PATCH 0/2] ARM: sa1100: move irq driver to irqchip subsystem
In-Reply-To: <1431987096-16308-1-git-send-email-dbaryshkov@gmail.com>
References: <1431987096-16308-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <alpine.DEB.2.11.1505191648200.4225@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 19 May 2015, Dmitry Eremin-Solenikov wrote:

> Hello,
> 
> These two patches finish my work on refactoring StrongARM SA-11x0 IRQ
> driver into sane irqchip driver. As they depend on the patches already
> accepted by Russell, I'd ask Thomas and/or Jason to Ack merging these
> two patches through his tree.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
