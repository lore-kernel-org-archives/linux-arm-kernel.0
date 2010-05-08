From: martinwguy@gmail.com (Martin Guy)
Date: Sat, 8 May 2010 18:32:47 +0100
Subject: [PATCH v7 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <3729cd3650f5af6aebfc5bae02ff6aad1b9b1e82.1273120206.git.mika.westerberg@iki.fi>
References: <cover.1273120206.git.mika.westerberg@iki.fi>
	<3729cd3650f5af6aebfc5bae02ff6aad1b9b1e82.1273120206.git.mika.westerberg@iki.fi>
Message-ID: <AANLkTimZywbu5KVvnUouLUoY1GUxWGlYoSgIbUlRDT5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/6/10, Mika Westerberg <mika.westerberg@iki.fi> wrote:
> This patch adds an SPI master driver for the Cirrus EP93xx SPI controller found
>  in EP93xx chips.

Hi
   I'm confused by the change in this version of the structure of the
board setup code.
   Can you post example patches for the board definitions of the
ts72xx and maybe also the Sim.One?
   I attach the board setup patches I had working with Sim.One v4, but
no longer see how to register the S1's card detect IRQ (the necessary
and the spi platform data.
   For a definitive Sim.One board definition I'll need to hear whether
they wish to assign a GPIO for the chip select (and which) in the next
board revision.

Thanks

     M
