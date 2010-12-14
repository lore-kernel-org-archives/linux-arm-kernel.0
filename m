From: linus.walleij@stericsson.com (Linus WALLEIJ)
Date: Tue, 14 Dec 2010 05:02:23 +0100
Subject: [PATCH 16/24] ARM: U300: update clock source registration
In-Reply-To: <E1PSDwf-0008DK-GC@rmk-PC.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
	<E1PSDwf-0008DK-GC@rmk-PC.arm.linux.org.uk>
Message-ID: <CEE6BB42CAD6E947908279175AF8470A075EEC1D73@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
> interfaces were added which simplify (and optimize) the selection of
> the
> divisor shift/mult constants.  Switch over to using this new interface.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@stericsson.com>

I remember pushing TGLX about simplifying mult/shift calculation
very early, it's nice to see it being ever more consolidated!

Yours,
Linus Walleij
