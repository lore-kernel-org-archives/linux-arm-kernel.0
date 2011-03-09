From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 Mar 2011 12:22:22 +0000
Subject: [PATCH 2/3] ARM: tegra: harmony: initialize the TPS65862 PMIC
In-Reply-To: <4D776A42.9030107@compulab.co.il>
References: <cover.1299588456.git.mike@compulab.co.il>
	<4ade6d195fff78271085eafb0a99de3be8beb426.1299588456.git.mike@compulab.co.il>
	<20110308131541.GB5892@sirena.org.uk>
	<4D772F23.70304@compulab.co.il>
	<20110309101508.GD6923@opensource.wolfsonmicro.com>
	<4D776A42.9030107@compulab.co.il>
Message-ID: <20110309122222.GG6923@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2011 at 01:53:38PM +0200, Mike Rapoport wrote:

> As for me, I'd be fine with registering only the pex_clk supply and ldo0 to
> allow PCI-e on Harmony :)
> If Tegra folks are Ok with it, I'd drop the rest and we'll add more regulators
> and supplies together with drivers that use them.

Note that there's no issue with having no supplies set for a regulator
so no reason not to register the supplies themselves, it's just the
supply map that I was flagging.
