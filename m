From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Oct 2014 09:43:39 -0700
Subject: [PATCH 00/13 v10] omap 8250 based UART + DMA
In-Reply-To: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <20141002164339.GL3122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140929 11:07]:
> The queue is getting smaller. The highlights of v9?v10
> - the DMA stall Frans Klaver reported which popped up in yocto is gone. It
>   also seems that the "ack the err-irq even if nothing happened" in EDMA
>   can be dropped.
> - the RX- and TX-DMA callbacks are now OMAP-only and no "bugs" flags are
>   introduced into the generic DMA code. This also means that there is
>   custom IRQ routine in case of DMA.

Looks good to me. For the patches that do not yet have my acks, please
feel free to add:

Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>

It's probably best that I queue the .dts changes separately though
to avoid pointless merge conflicts.

Regards,

Tony
