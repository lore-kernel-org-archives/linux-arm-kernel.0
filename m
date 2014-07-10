From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Thu, 10 Jul 2014 15:54:07 +0100
Subject: [PATCH 2/6] tty: serial: 8250 core: allow to overwrite & export
 serial8250_startup()
In-Reply-To: <1404928177-26554-3-git-send-email-bigeasy@linutronix.de>
References: <1404928177-26554-1-git-send-email-bigeasy@linutronix.de>
 <1404928177-26554-3-git-send-email-bigeasy@linutronix.de>
Message-ID: <20140710155407.3affb663@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  9 Jul 2014 19:49:33 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> The OMAP version of the 8250 can actually use 1:1 serial8250_startup().
> However it needs to be extended by a wakeup irq which should to be
> requested & enabled at ->startup() time and disabled at ->shutdown() time.
> 
> v1?v2: add shutdown callback
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

1,2 & 4

Acked by: Alan Cox <alan@linux.intel.com>
