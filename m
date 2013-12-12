From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Dec 2013 22:30:21 +0100
Subject: [PATCH 05/12] clk: SPEAr13xx: Fix pcie clock name
In-Reply-To: <2CC2A0A4A178534D93D5159BF3BCB66189F95F642A@EAPEX1MAIL1.st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <201312112342.43840.arnd@arndb.de>
 <2CC2A0A4A178534D93D5159BF3BCB66189F95F642A@EAPEX1MAIL1.st.com>
Message-ID: <201312122230.21828.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 December 2013, Mohit KUMAR DCG wrote:
> > 
> > I think in the future, the spear clocks really need to get moved into DT
> > representations, as we do for other platforms, which will get rid of a lot of
> > code in drivers/clk, including all the clkdev registration.
>
> -  Let it be this way for now. May be we will improve it in next cycle

Fair enough. This will be a major change that doesn't have to delay the PCIe
driver, just make sure you can address the other comments I made for now.

The clock situation will have to be worked out though before the bindings
can be considered stable, because you will have to add mandatory 'clocks'
properties to a lot of them.

	Arnd
