From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Wed, 31 Aug 2016 14:08:54 +0530
Subject: [PATCH 2/2] ARM: dts: dra7: cpsw: fix clocks tree
In-Reply-To: <20160830145801.10364-2-grygorii.strashko@ti.com>
References: <20160830145801.10364-1-grygorii.strashko@ti.com>
 <20160830145801.10364-2-grygorii.strashko@ti.com>
Message-ID: <94120809-8e43-36f2-152a-e82fadfa1095@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 August 2016 08:28 PM, Grygorii Strashko wrote:
> Current clocks tree definition for CPSW/CPTS doesn't
> correspond TRM for dra7/am57 SoCs.
> 
> CPTS: has to be sourced from gmac_rft_clk_mux clock
> CPSW: DPLL_GMAC -> CLKOUT_M2 -> GMAC_250M_CLK -> 1/2 ->
>       -> GMAC_MAIN_CLK (125 MHZ)
> 
> Hence, correct clock tree for GMAC_MAIN_CLK and use proper
> clock for CPTS. This also require updating of CPTS clock
> multiplier.
> 
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Mugunthan V N <mugunthanvnm@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Reviewed-by: Mugunthan V N <mugunthanvnm@ti.com>

Regards
Mugunthan V N
