From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jun 2012 18:14:10 +0100
Subject: [PATCH] ARM: fiq: change FIQ_START to a variable
In-Reply-To: <20120629124554.GH29197@S2101-09.ap.freescale.net>
References: <1340867264-23043-1-git-send-email-shawn.guo@linaro.org>
 <20120629120057.GF29197@S2101-09.ap.freescale.net>
 <20120629121317.GC16319@n2100.arm.linux.org.uk>
 <20120629124554.GH29197@S2101-09.ap.freescale.net>
Message-ID: <20120629171410.GA29602@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 08:45:56PM +0800, Shawn Guo wrote:
> On Fri, Jun 29, 2012 at 01:13:17PM +0100, Russell King - ARM Linux wrote:
> > To be frank, I've not been paying attention to it.  This patch looks okey
> > as a stop gap solution but in the longer run it must stop using the genirq
> > stuff, as I've already said.
> 
> So can I have your ack to bless the patch going through arm-soc tree
> as the part of imx sparse-irq series?  Thanks.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
