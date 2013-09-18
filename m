From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 18 Sep 2013 17:48:58 +0300
Subject: [PATCH 00/12] Introduce common infra for tegra clocks
In-Reply-To: <1379515331-19427-1-git-send-email-pdeschrijver@nvidia.com>
References: <1379515331-19427-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20130918144858.GV30013@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 18, 2013 at 04:40:52PM +0200, Peter De Schrijver wrote:
> This patchset introduces common infrastructure for clocks which exist in
> several Tegra SoCs. We also move Tegra114 to this new infrastructure.
> Tegra20 and Tegra30 will be moved later in separate patchsets.
> 
> Peter De Schrijver (12):
>   clk: tegra: simplify periph clock data
>   clk: tegra: periph_clk_enb_refcnt as common infra
>   clk: tegra: Add TEGRA_PERIPH_NO_DIV flag
>   clk: tegra: move some PLLC and PLLXC init to clk-pll.c
>   clk: tegra: add header for common tegra clock IDs
>   clk: tegra: add common infra for DT clocks
>   clk: tegra: move audio clk to common file
>   clk: tegra: move periph clocks to common file
>   clk: tegra: move PMC clocks to common file
>   clk: tegra: move fixed clocks to common file
>   clk: tegra: introduce common tegra_osc_clk_init
>   clk: tegra: introduce common gen4 super clock

Forgot to mention that this patchset relies on 

[PATCH] clk: tegra: replace enum tegra114_clk by binding header 

and obsoletes:

[PATCH v2 0/4] Introduce table driven initializations
