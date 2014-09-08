From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 8 Sep 2014 16:33:29 -0700
Subject: [PATCH 03/18] tty: serial: 8250_core: allow to set ->throttle /
 ->unthrottle callbacks
In-Reply-To: <1409943773-7874-4-git-send-email-bigeasy@linutronix.de>
References: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
 <1409943773-7874-4-git-send-email-bigeasy@linutronix.de>
Message-ID: <20140908233329.GA32144@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 05, 2014 at 09:02:38PM +0200, Sebastian Andrzej Siewior wrote:
> The OMAP UART provides support for HW assisted flow control. What is
> missing is the support to throttle / unthrottle callbacks which are used
> by the omap-serial driver at the moment.
> This patch adds the callbacks. It should be safe to add them since they
> are only invoked from the serial_core (uart_throttle()) if the feature
> flags are set.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Due to other recent changes, this patch fails to apply :(

I've applied your first two, can you respin the rest and resend as a new
series?

thanks,

greg k-h
