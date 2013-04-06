From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 6 Apr 2013 15:09:39 +0200
Subject: [PATCH v3 0/5] Device Bus support for Marvell EBU SoC
In-Reply-To: <1365246930-13315-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1365246930-13315-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <201304061509.39253.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 06 April 2013, Ezequiel Garcia wrote:
> Now that the mbus driver has been added to manage address decoding
> windows it's possible to introduce the Device Bus driver.
> This driver allows to access several memories and I/O devices
> such as NOR, NAND, SRAM and FPGAs.

Yes, I think this is good, I only have two trivial comments for the first
patch that I'd like you to address.

The ranges property for the devbus itself will obviously change later
when the mbus driver is there, but that should not impact the binding
for the devbus, so from my point of view it can go into 3.10.

	Arnd
