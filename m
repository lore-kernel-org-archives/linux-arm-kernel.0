From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 25 Apr 2010 03:59:26 +0200
Subject: [PATCH 1/7] PL330: Add common core driver
In-Reply-To: <n2y1b68c6791004231620lcd670271u3a9d33bb52c10e37@mail.gmail.com>
References: <1271834848-29179-1-git-send-email-jassisinghbrar@gmail.com>
	<j2x63386a3d1004231449ta90046b5pc29622b58a87b99a@mail.gmail.com>
	<n2y1b68c6791004231620lcd670271u3a9d33bb52c10e37@mail.gmail.com>
Message-ID: <q2y63386a3d1004241859v8b31f756rb6ff9b4a7452ba@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/4/24 jassi brar <jassisinghbrar@gmail.com>:

> You mean the DMA engine driver for PL330, right?
> Since Joonyoung's driver was pre-empted by these patches,
> he might want to re-write parts of his driver for this backend.
> If he doesn't show any interest in a few days, I'll do it.

Great, my interest here is mainly that this PrimeCell has
a DMAengine API, if it e.g. runs the DMAengine tests
nicely, we know it works.

> Btw, I think that driver should be divided in two files
> drivers/dma/api-pl330.c with common code and
> drivers/dma/<soc>-pl330.c for platform specific stuff like IRQ,
> registers base mapping and other quirks(if any). Any opinions?

Sounds like a plan, this design pattern is already in a lot
of shared peripherals like drivers/usb/musb for example.

Yours,
Linus Walleij
