From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 19 Jul 2010 18:03:25 +0200
Subject: [spi-devel-general] [PATCH 2/2] SPI: make the moved loopback test
	work
In-Reply-To: <377310.49674.qm@web180311.mail.gq1.yahoo.com>
References: <AANLkTikfwTxZ4iMaveddXLd1Z2phF0hVi_yG7A2wUNCo@mail.gmail.com>
	<377310.49674.qm@web180311.mail.gq1.yahoo.com>
Message-ID: <AANLkTimfLOSQWDhUkha_1i39E_gKHdto09ZrrGfqNiGC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/19 David Brownell <david-b@pacbell.net>:

> A dedicated loopback test is the wrong model,
> given that SPI_LOOP exists. ?And is even used
> in the sample userspace code ...

Yeah I see, I never quite understood how SPI_LOOP
was intended really.
