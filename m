From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Mon, 5 Jan 2015 21:26:50 +0000
Subject: [PATCH] tty: serial: 8250: omap: add ttySx console if the user
 didn't
In-Reply-To: <20141218174712.GA26632@linutronix.de>
References: <1417039306-2384-1-git-send-email-bigeasy@linutronix.de>
 <20141129094823.GA10840@linutronix.de>
 <20141129173418.GY2817@atomide.com>
 <20141201140914.728aaa46@lxorguk.ukuu.org.uk>
 <20141201231338.GA14524@fuloong-minipc.musicnaut.iki.fi>
 <20141202015118.GA1891@saruman>
 <20141205135133.37fb96f6@lxorguk.ukuu.org.uk>
 <20141218174712.GA26632@linutronix.de>
Message-ID: <20150105212650.701af128@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Dec 2014 18:47:12 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> This patch invokes add_preferred_console() with ttyS based on ttyO
> arguments if the user didn't specify it on its own. This ensures that
> the user will see the kernel booting on his serial console in case he
> forgot to update the command line.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Alan Cox <alan@linux.intel.com>
