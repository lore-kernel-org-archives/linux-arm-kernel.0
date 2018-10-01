From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 01 Oct 2018 15:13:57 -0700
Subject: [PATCH] clk: mvebu: ap806: Remove superfluous of_clk_add_provider
In-Reply-To: <20180912153549.14437-1-gregory.clement@bootlin.com>
References: <20180912153549.14437-1-gregory.clement@bootlin.com>
Message-ID: <153843203729.119890.12688306651431407723@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Gregory CLEMENT (2018-09-12 08:35:49)
> While applying the commit a8309cedcdce ("clk: apn806: Add eMMC clock to
> system controller driver"), of_clk_add_provider was added wheres it was
> already present in the probe function.
> 
> This extraneous call is harmless but not useful so remove it.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---

Applied to clk-next
