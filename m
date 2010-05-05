From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 May 2010 20:45:56 +0100
Subject: [PATCH 12/18] OMAP3 : clock data: Update name string for EMAC
	clocks
In-Reply-To: <20100505193308.21568.98880.stgit@baageli.muru.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
	<20100505193308.21568.98880.stgit@baageli.muru.com>
Message-ID: <20100505194556.GB17678@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 05, 2010 at 12:33:09PM -0700, Tony Lindgren wrote:
> The emac driver uses generic name for the module and phy
> clocks. Updated the omap3xxx_clks table to match the names
> used by the Davinci emac driver.

Patch doesn't match description.  IMHO "ick" and "fck" are generic names,
whereas "emac_clk" and "phy_clk" are specific names.

> -	CLK("davinci_emac",	"ick",		&emac_ick,	CK_AM35XX),
> -	CLK("davinci_emac",	"fck",		&emac_fck,	CK_AM35XX),
> +	CLK("davinci_emac",	"emac_clk",	&emac_ick,	CK_AM35XX),
> +	CLK("davinci_emac",	"phy_clk",	&emac_fck,	CK_AM35XX),
