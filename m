From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Aug 2011 16:08:07 +0100
Subject: [PATCH 11/13] ARM: gpio: consolidate trivial gpiolib
	implementations
In-Reply-To: <017101cc581c$6e277530$4a765f90$%kim@samsung.com>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
	<E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
	<017101cc581c$6e277530$4a765f90$%kim@samsung.com>
Message-ID: <20110811150807.GB4924@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2011 at 08:47:18PM +0900, Kukjin Kim wrote:
> Russell King - ARM Linux wrote:
> > 
> > Consolidate 24 trivial gpiolib implementions out of mach/gpio.h
> > into asm/gpio.h.  This is basically the include of asm-generic/gpio.h
> > and the definition of gpio_get_value, gpio_set_value, and gpio_cansleep
> > as described in Documentation/gpio.txt
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> on following Samsung stuff...

Thanks.

> As a note, there were duplicated e-mail address Grant and Nicolas in Cc ;)
> I just pushed 'reply all' :)

That's not in the original email, and isn't in any one elses replies....
