From: david-b@pacbell.net (David Brownell)
Date: Sat, 28 Nov 2009 14:09:13 -0800
Subject: [PATCH] warn about shared irqs requesting IRQF_DISABLED
	registered with setup_irq
In-Reply-To: <20091128200344.GA1272@pengutronix.de>
References: <20091127195857.GB28193@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0911272234460.24119@localhost.localdomain>
	<20091128200344.GA1272@pengutronix.de>
Message-ID: <200911281409.13807.david-b@pacbell.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 28 November 2009, Uwe Kleine-K?nig wrote:
> ?I just thought that a
> warning that is triggered with request_irq and request_threaded_irq
> shouldn't be skipped when using setup_irq.

Seems fair to me.
