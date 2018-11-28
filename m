From: linux@dominikbrodowski.net (Dominik Brodowski)
Date: Wed, 28 Nov 2018 15:34:46 +0100
Subject: [PATCH 0/8] SA11xx PCMCIA updates and GPIOD conversion
In-Reply-To: <20181128111041.GG30658@n2100.armlinux.org.uk>
References: <20181128111041.GG30658@n2100.armlinux.org.uk>
Message-ID: <20181128143446.GA10668@light.dominikbrodowski.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 11:10:41AM +0000, Russell King - ARM Linux wrote:
> This series adds a generic MAX1600 library which uses the GPIOD
> interfaces to control the PCMCIA power switches, and converts
> some SA11x0/PXA drivers to it, reducing the code duplication.
> This also allows us to kill the SA1111 private GPIO interfaces.

As I'll presume you'll push this upstream via arm, you may add my

	Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

in relation to the PCMCIA-related changes.

Thanks,
	Dominik
