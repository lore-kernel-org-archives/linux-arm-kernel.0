From: rubini@unipv.it (Alessandro Rubini)
Date: Mon, 21 Sep 2009 12:48:14 +0200
Subject: [PATCH] Don't disable irqs in set_next_event and set_mode
	callbacks
In-Reply-To: <20090921093037.GE27357@n2100.arm.linux.org.uk>
References: <20090921093037.GE27357@n2100.arm.linux.org.uk>
	<1253518763-15087-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20090921090400.GD27357@n2100.arm.linux.org.uk>
	<20090921091614.GA25422@pengutronix.de>
Message-ID: <20090921104813.GA13788@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Nomadik only works because it doesn't support periodic mode.

s/periodic/one-shot/

Uwe, I can't test it as my board is currently unavailable, but I have
no problems in removing the irqsave stuff if not needed. Actually,
I use the atmel code as a reference, so I got the irqsave from there.

Feel free to add my acked-by if you think it's worth.

/alessandro
