From: peter@hurleysoftware.com (Peter Hurley)
Date: Fri, 03 Oct 2014 09:08:08 -0400
Subject: [PATCH 00/13 v10] omap 8250 based UART + DMA
In-Reply-To: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <542E9FB8.3080201@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/29/2014 02:06 PM, Sebastian Andrzej Siewior wrote:
> The queue is getting smaller. The highlights of v9?v10
> - the DMA stall Frans Klaver reported which popped up in yocto is gone. It
>   also seems that the "ack the err-irq even if nothing happened" in EDMA
>   can be dropped.
> - the RX- and TX-DMA callbacks are now OMAP-only and no "bugs" flags are
>   introduced into the generic DMA code. This also means that there is
>   custom IRQ routine in case of DMA.

For the series:

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
