From: tony@atomide.com (Tony Lindgren)
Date: Mon, 1 Dec 2014 08:38:13 -0800
Subject: [PATCH] tty: serial: serial-omap: depend on !8250_omap
In-Reply-To: <20141201140914.728aaa46@lxorguk.ukuu.org.uk>
References: <1417039306-2384-1-git-send-email-bigeasy@linutronix.de>
 <20141129094823.GA10840@linutronix.de>
 <20141129173418.GY2817@atomide.com>
 <20141201140914.728aaa46@lxorguk.ukuu.org.uk>
Message-ID: <20141201163813.GA2817@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk> [141201 06:11]:
> > Well the nightmare userspace switch from ttyS to ttyO few years ago is
> > something we want to avoid.. I think the best solution would be to make
> > serial-omap.c transparently provide support for ttyO using the new 8250
> > code so both ttyS and ttyO devices would just work. Otherwise it will
> > be years of "my serial port stopped working" questions again.
> 
> Thata a udev problem not a kernel one surely.

How do you suggest we get people to update their kernel command line
and inittab? Udev may not even be installed.

Regards,

Tony
