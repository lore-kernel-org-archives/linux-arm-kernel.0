From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Nov 2013 12:10:37 +0100
Subject: [PATCH v4 4/4] ARM: new platform for Energy Micro's EFM32
 Cortex-M3 SoCs
In-Reply-To: <20131105094854.GL14892@pengutronix.de>
References: <20131104105836.GI14892@pengutronix.de>
 <201311041456.27654.arnd@arndb.de> <20131105094854.GL14892@pengutronix.de>
Message-ID: <201311051210.38434.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 November 2013, Uwe Kleine-K?nig wrote:
> I have links to the datasheet of the processor and the user manual of
> the board in the corresponding device trees. Also I added a paragraph to
> the commit log mentioning the development board I used:
> 
>         There are still some missing parts (e.g. board support, device
>         trees), but with these bits added on top of this patch I can
>         successfully boot a EFM32GG-DK3750 board that uses an
>         EFM32GG990F1024.
> 
> Good enough?
> 

Ok, works for me.

	Arnd
