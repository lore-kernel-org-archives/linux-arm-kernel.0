From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 15 Jul 2010 10:09:33 +0100
Subject: [PATCH v2 2/2] ux500: add ab8500-regulators machine specific data
In-Reply-To: <AANLkTimWjozzhTG491JVLUIICh6YonO4Emp07AG1nMj-@mail.gmail.com>
References: <20100714145748.GF31073@rakim.wolfsonmicro.main>
	<20100714153643.GB1689@bnru01.bnr.st.com>
	<20100714154726.GH31073@rakim.wolfsonmicro.main>
	<20100714160941.GC1689@bnru01.bnr.st.com>
	<20100714162048.GA27512@rakim.wolfsonmicro.main>
	<20100714164708.GD1689@bnru01.bnr.st.com>
	<20100714170323.GF5933@sirena.org.uk>
	<20100714173650.GA21893@bnru01.bnr.st.com>
	<20100714184251.GG5933@sirena.org.uk>
	<AANLkTimWjozzhTG491JVLUIICh6YonO4Emp07AG1nMj-@mail.gmail.com>
Message-ID: <20100715090932.GC23529@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 15, 2010 at 12:51:50AM +0200, Linus Walleij wrote:

> For U8500 there is a dedicated autonomous system in the silicon, called
> PRCMU (Power Reset Clock Management Unit) that will actually do
> this using I2C because it has its own CPU and can transmit I2C
> messages even when the ARM CPU cores are turned off. So this is
> indeed a first-timer and not strange that it looks unfamiliar ...

This sort of design is becoming more and more common but it's still the
same thing from the point of view of the kernel - something else goes
off and does magic without the kernel explicitly doing anything.
