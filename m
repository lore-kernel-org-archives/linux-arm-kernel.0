From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 5 Nov 2014 19:14:21 -0800
Subject: [PATCH 00/13 v10] omap 8250 based UART + DMA
In-Reply-To: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <20141106031421.GA22185@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 08:06:36PM +0200, Sebastian Andrzej Siewior wrote:
> The queue is getting smaller. The highlights of v9?v10
> - the DMA stall Frans Klaver reported which popped up in yocto is gone. It
>   also seems that the "ack the err-irq even if nothing happened" in EDMA
>   can be dropped.
> - the RX- and TX-DMA callbacks are now OMAP-only and no "bugs" flags are
>   introduced into the generic DMA code. This also means that there is
>   custom IRQ routine in case of DMA.

I've now applied the patches here that I could, if I have missed any,
please let me know and resend.

thanks,

greg k-h
