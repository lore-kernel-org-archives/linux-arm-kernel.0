From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 30 Nov 2014 12:51:58 +0100
Subject: [PATCH v3 0/3] SoCFPGA: L3 NIC driver
In-Reply-To: <1417292052-12974-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1417292052-12974-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <14512010.yFXFS4V07x@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 29 November 2014 21:14:09 Steffen Trumtrar wrote:
> Hi!
> 
> This series adds support for the SoCFPGA L3 NIC. As the memory range has
> a lot of holes, where you can not read from, syscon can not be used for
> this IP core. Instead add a new driver, that knows about all the allowed
> ranges and guards the access via regmap.

What is an L3 NIC?

	Arnd
