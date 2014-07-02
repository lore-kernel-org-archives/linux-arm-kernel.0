From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Wed, 2 Jul 2014 22:09:44 +0300
Subject: [RFC PATCH] tty: serial: Add 8250-core based omap driver
In-Reply-To: <20140702160932.GF5541@saruman.home>
References: <1404316809-20637-1-git-send-email-bigeasy@linutronix.de>
 <20140702160932.GF5541@saruman.home>
Message-ID: <20140702190944.GA567@drone.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 02, 2014 at 11:09:32AM -0500, Felipe Balbi wrote:
> > It has been only tested as console UART.
> > The tty name is ttyS based instead of ttyO. How big is the pain here,
> > what could be the easiest way to provide compatibility?
> 
> have been considering that myself for months. You could pass an optional
> argument to serial8250_register_8250_port() but that only solves part of
> the problem :-(

When ttyS -> ttyO change was done on OMAP, compatibility was not an issue.
Why should we care about it now?

A.
