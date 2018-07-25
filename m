From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 25 Jul 2018 16:42:09 -0700
Subject: [PATCH v7 1/5] clk: actions: Add missing REGMAP_MMIO dependency
In-Reply-To: <20180719090649.12460-2-sravanhome@gmail.com>
References: <20180719090649.12460-1-sravanhome@gmail.com>
 <20180719090649.12460-2-sravanhome@gmail.com>
Message-ID: <153256212945.48062.14143557798405781571@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Saravanan Sekar (2018-07-19 02:06:45)
> Add REGMAP_MMIO as dependency to avoid undefined
> reference to regmap symbols.
> 
> Fixes: d85d20053e19 ("clk: actions: Add S900 SoC clock support")
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Andreas F?rber <afaerber@suse.de>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Applied to clk-next
