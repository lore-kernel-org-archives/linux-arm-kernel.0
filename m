From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Mon, 7 Jul 2014 14:09:46 +0100
Subject: [RFC PATCH 2/4] tty: serial: 8250 core: allow to overwrite &
 export serial8250_startup()
In-Reply-To: <1404491651-1388-2-git-send-email-bigeasy@linutronix.de>
References: <1404491651-1388-1-git-send-email-bigeasy@linutronix.de>
 <1404491651-1388-2-git-send-email-bigeasy@linutronix.de>
Message-ID: <20140707140946.6f16f2e4@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  4 Jul 2014 18:34:09 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> The OMAP version of the 8250 can actually use 1:1 serial8250_startup().
> However it needs to be extended by a wakeup irq which should to be
> requested & enabled at ->startup() time.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Alan Cox <alan@linux.intel.com>
