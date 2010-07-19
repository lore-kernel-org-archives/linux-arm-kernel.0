From: david-b@pacbell.net (David Brownell)
Date: Mon, 19 Jul 2010 03:16:12 -0700 (PDT)
Subject: [spi-devel-general] [PATCH 2/2] SPI: make the moved loopback test
	work
In-Reply-To: <AANLkTikfwTxZ4iMaveddXLd1Z2phF0hVi_yG7A2wUNCo@mail.gmail.com>
Message-ID: <377310.49674.qm@web180311.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A dedicated loopback test is the wrong model,
given that SPI_LOOP exists.  And is even used
in the sample userspace code ...

- Dave
