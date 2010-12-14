From: linus.walleij@stericsson.com (Linus WALLEIJ)
Date: Tue, 14 Dec 2010 05:04:01 +0100
Subject: [PATCH 20/24] ARM: nomadik: update clock source registration
In-Reply-To: <E1PSDxy-0008Da-Su@rmk-PC.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
	<E1PSDxy-0008Da-Su@rmk-PC.arm.linux.org.uk>
Message-ID: <CEE6BB42CAD6E947908279175AF8470A075EEC1D74@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Russell King [mailto:rmk at arm.linux.org.uk] On Behalf Of Russell
>
> In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
> interfaces were added which simplify (and optimize) the selection of
> the
> divisor shift/mult constants.  Switch over to using this new interface.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
