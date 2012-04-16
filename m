From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Apr 2012 15:40:08 +0000
Subject: [PATCH 00/12] at91: 3.4-rc3 fixes
In-Reply-To: <cover.1334567594.git.nicolas.ferre@atmel.com>
References: <cover.1334567594.git.nicolas.ferre@atmel.com>
Message-ID: <201204161540.08389.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 April 2012, Nicolas Ferre wrote:
> Here is another fixes series for AT91 that will go on top of 3.4-rc3.
> We experienced some issues while compiling some drivers as modules: Joachim has
> corrected several of them. We may reduce this number of exported values by
> reworking some drivers, in the future.
> Some drivers are also modified here, I would like to keep them in the series
> as the modifications are really related with our recent move to irqdomains or
> simply related with compiler annotations.

I looked at all the patches, they look good to me, but patch 9 does not
seem to be an actual bug-fix rather than a cleanup, so you might want
to put that into a different series.

	Arnd
