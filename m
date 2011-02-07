From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Feb 2011 07:59:16 -0800
Subject: [RFC 2/5] ARM: P2V: avoid initializers and assembly using
	PHYS_OFFSET
In-Reply-To: <20110106090855.GR8638@n2100.arm.linux.org.uk>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDOv-00023d-Gi@rmk-PC.arm.linux.org.uk>
	<20110106085145.GB26617@pengutronix.de>
	<20110106090855.GR8638@n2100.arm.linux.org.uk>
Message-ID: <20110207155916.GF20795@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110106 01:16]:
> On Thu, Jan 06, 2011 at 09:51:45AM +0100, Sascha Hauer wrote:
> > As Russell noted this conflicts with the current i.MX branch. In current
> > i.MX branch we have:
> > 
> > -       .boot_params = PHYS_OFFSET + 0x100,
> > +       .boot_params = MX51_PHYS_OFFSET + 0x100,
> > 
> > PLAT_PHYS_OFFSET should be defined to MX51_PHYS_OFFSET, so it shouldn't
> > matter which solution to the conflict we choose.
> 
> I've actually dropped my modifications to this files as your change
> to them makes more sense longer term.

Acked-by: Tony Lindgren <tony@atomide.com>
