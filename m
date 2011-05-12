From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 12 May 2011 10:03:26 +0200 (CEST)
Subject: [PATCH 06/13] clocksource: add common mmio clocksource
In-Reply-To: <E1QJhNe-0000yh-HS@rmk-PC.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<E1QJhNe-0000yh-HS@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1105121001590.2794@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 May 2011, Russell King - ARM Linux wrote:

> Add a generic mmio clocksource, covering both 32-bit and 16-bit register
> access sizes, for up or down counters.  This can be used to easily
> create clocksources for simple counter-based implementations.
> 
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Colin Cross <ccross@android.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Erik Gilling <konkers@android.com>
> Cc: "Hans J. Koch" <hjk@hansjkoch.de>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khc@pm.waw.pl>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Lennert Buytenhek <kernel@wantstofly.org>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: linux-omap at vger.kernel.org
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Please take this through the ARM tree. It's not conflicting with
anything in my tree.
