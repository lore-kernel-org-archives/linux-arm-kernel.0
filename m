From: tony@atomide.com (Tony Lindgren)
Date: Tue, 15 Feb 2011 10:05:34 -0800
Subject: [PATCH v7 3/4] TI816X: Create board support and enable build
	for TI816X EVM
In-Reply-To: <20110215180139.GF11199@n2100.arm.linux.org.uk>
References: <1297791368-32042-1-git-send-email-hemantp@ti.com>
	<20110215180139.GF11199@n2100.arm.linux.org.uk>
Message-ID: <20110215180533.GA20795@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110215 10:00]:
> On Tue, Feb 15, 2011 at 11:06:08PM +0530, Hemant Pedanekar wrote:
> > +static void __init ti8168_evm_init_irq(void)
> > +{
> > +	omap_board_config = ti8168_evm_config;
> > +	omap_board_config_size = ARRAY_SIZE(ti8168_evm_config);
> > +	omap2_init_common_infrastructure();
> > +	omap2_init_common_devices(NULL, NULL);
> > +	omap_init_irq();
> > +}
> 
> What here can use the new init_early hook in the machine record?

I can fix this up for the init_early changes when I merge the branches
together.

Tony
