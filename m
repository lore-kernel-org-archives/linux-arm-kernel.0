From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 1 Mar 2014 16:31:13 +0100 (CET)
Subject: [PATCH] irq: Changed the return type of irq_chip.irq_startup()
 from unsigned int to int
In-Reply-To: <7150036.UpHTd1PK1K@radagast>
References: <CACh+v5Nkuct0J65OHcnSd6Dfq4EyfafY8RpTvdwKXUA7A8_+Xw@mail.gmail.com>
 <1393521679-32331-1-git-send-email-jjhiblot@traphandler.com>
 <7150036.UpHTd1PK1K@radagast>
Message-ID: <alpine.DEB.2.02.1403011629540.18573@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Feb 2014, James Hogan wrote:
> On Thursday 27 February 2014 18:21:19 Jean-Jacques Hiblot wrote:
> >  drivers/irqchip/irq-metag.c               | 4 ++--
> 
> I think you've missed out drivers/irqchip/irq-metag-ext.c

There is a good reason why I asked to do this with coccinelle.

Thanks,

	tglx
