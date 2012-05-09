From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 May 2012 14:40:14 +0000
Subject: [PATCHv3] Add ADC driver for Atmel G20, G45 and X5 boards
In-Reply-To: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <201205091440.14587.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 May 2012, Maxime Ripard wrote:
> Here is another version of the patches to bring ADC driver to Atmel boards.
> Since last version, here is what changed:
>   * Rebased on top of staging-next to move out of staging. Had to change to IIO
>     kfifo buffer along the way.
>   * Reworked the DT bindings according to Jean-Christophe reviews
>   * Made various fixes according to reviews
>   * Support for X5 boards

What's the reason for providing both DT and non-DT probing in that driver?
Doesn't it make more sense to just require that everyone who uses this
device boots using the device tree?

	Arnd
