From: marex@denx.de (Marek Vasut)
Date: Fri, 6 Dec 2013 12:43:55 +0100
Subject: i.MX6/PCIe and MSI interrupts
In-Reply-To: <201312061032.31944.jbe@pengutronix.de>
References: <201312061032.31944.jbe@pengutronix.de>
Message-ID: <201312061243.56069.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 06, 2013 at 10:32:31 AM, J?rgen Beisert wrote:
> Hi,
> 
> is anybody out there who has MSI interrupts successfully working on i.MX6?
> I tried with my i.MX6 and a Gbit network card but without success. In
> legacy interrupt mode it works.

What precise model of card do you use ? Do you have a PCIe switch in the path or 
just direct RC-EP connection ?

> I'm using various patches here from the list and the PCIe itself works. The
> designware driver is prepared for MSI interrupts and the Exynos driver
> makes use of it.

OK

> I added the same glue code to the i.MX6 driver but I can't get the INTD
> interrupt to fire when MSI arrives (while the INTA fires in legacy
> interrupt mode). Some idea what needs to be done in the i.MX6 to get MSI
> working? The Exynos driver additionally changes some bits in its chipset
> beside the PCIe unit to enable the MSI interrupt to its CPU. Are there
> some 'hidden' bits in the i.MX6 as well?

Can you post your prototype patch for the PCIe MSI so we can see what you did 
there please?

Best regards,
Marek Vasut
