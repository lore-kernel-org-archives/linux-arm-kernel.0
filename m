From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 24 Jun 2014 00:40:01 +0200 (CEST)
Subject: [PATCH v3 1/7] genirq: generic chip: export irq_map_generic_chip
 function
In-Reply-To: <20140623221733.GG10202@titan.lakedaemon.net>
References: <1403276487-8792-1-git-send-email-boris.brezillon@free-electrons.com>
 <1403276487-8792-2-git-send-email-boris.brezillon@free-electrons.com>
 <20140623221733.GG10202@titan.lakedaemon.net>
Message-ID: <alpine.DEB.2.10.1406240019370.5170@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Jun 2014, Jason Cooper wrote:

> Thomas,
> 
> Would you mind Acking this and letting me know how you'd like me to
> handle it?  It's a build requirement for the rest of the series, but
> it's in core code.
> 
> I can do a separate topic branch for you or just merge it in with
> irqchip/core.  Whichever is easiest for you.

Just keep it in the series.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
