From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 25 Jul 2010 10:14:19 +0200
Subject: [spi-devel-general] [PATCH 2/2] SPI: make the moved loopback test
	work
In-Reply-To: <AANLkTinFqwexhf5g3JMeN2eedRHbo8eTgaD-eqfWkU=B@mail.gmail.com>
References: <AANLkTinm_bvpcQogsTgVy5ZX1MFajVvDxBtVJ056sTyq@mail.gmail.com>
	<812288.2599.qm@web180314.mail.gq1.yahoo.com>
	<AANLkTilqKs4WcSXxrZPUuaTudLD-P8ZeA6ShGyLmAIhi@mail.gmail.com>
	<AANLkTinFqwexhf5g3JMeN2eedRHbo8eTgaD-eqfWkU=B@mail.gmail.com>
Message-ID: <AANLkTimLjj2Ux9htYYhHjY4BhkxmOn6mcUFaD3jtWt+G@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/25 Grant Likely <grant.likely@secretlab.ca>:

> What's disagreed with is the dummy device knowing the intimate working
> details of the SPI bus driver.

OK I'll send the other patch I've been holding back, it merges that part into
the driver itself so it sits in the apropriate containment, and solves
that specific issue.

But I understood Davids criticism like this: "you shouldn't make tests
using loopback for a specific driver, it should be generic, i.e. being
able to perform a loopback test on any driver supporting SPI_LOOP".

A generic loopback test is a lot harder for me to produce, that's
why I was troubled...

Yours,
Linus Walleij
