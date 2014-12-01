From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 2 Dec 2014 01:13:38 +0200
Subject: [PATCH] tty: serial: serial-omap: depend on !8250_omap
In-Reply-To: <20141201140914.728aaa46@lxorguk.ukuu.org.uk>
References: <1417039306-2384-1-git-send-email-bigeasy@linutronix.de>
 <20141129094823.GA10840@linutronix.de>
 <20141129173418.GY2817@atomide.com>
 <20141201140914.728aaa46@lxorguk.ukuu.org.uk>
Message-ID: <20141201231338.GA14524@fuloong-minipc.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 01, 2014 at 02:09:14PM +0000, One Thousand Gnomes wrote:
> > Well the nightmare userspace switch from ttyS to ttyO few years ago is
> > something we want to avoid.. I think the best solution would be to make
> > serial-omap.c transparently provide support for ttyO using the new 8250
> > code so both ttyS and ttyO devices would just work. Otherwise it will
> > be years of "my serial port stopped working" questions again.
> 
> Thata a udev problem not a kernel one surely.

People also use serial console to observe the early kernel boot before
the userspace is started.

A.
