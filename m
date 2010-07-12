From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Jul 2010 09:12:45 +0100
Subject: [RFC PATCH 1/2] allow each machine to specify it's own IRQ
	handlers at run-time
In-Reply-To: <20100712081106.GB1532@pengutronix.de>
References: <AANLkTin9OHUGtKSg7554ucVhufQ3PiKXALmD0Lh7A-yt@mail.gmail.com>
	<20100712081106.GB1532@pengutronix.de>
Message-ID: <20100712081245.GC22138@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 12, 2010 at 10:11:06AM +0200, Uwe Kleine-K?nig wrote:
> I didn't thought it would be that easy.  Nice.
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

It isn't - if you enable this, your platform will break because
there's no implementations of it.  That makes this patch rather
hard to ack on its own.
