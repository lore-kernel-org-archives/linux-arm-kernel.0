From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 01 Sep 2016 19:32:18 +0200
Subject: [PATCH v2 2/3] clk: samsung: exynos5420: Add clocks for CMU_CDREX
 domain
In-Reply-To: <1472108238-24309-3-git-send-email-cw00.choi@samsung.com>
References: <1472108238-24309-1-git-send-email-cw00.choi@samsung.com>
 <1472108238-24309-3-git-send-email-cw00.choi@samsung.com>
Message-ID: <5c3c5a13-ca2b-272d-e137-d7eaaffaafac@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/25/2016 08:57 AM, Chanwoo Choi wrote:
> This patch adds the mux/divider clocks for CMU_CDREX (DRAM Express
> Controller) which generates the clocks for DRAM and NoC (Network on Chip) bus
> clock. But, there is differnet source of MUX_MX_MSPLL_CCORE between exynos5420
> and exynos5422. So, each MUX_MX_MSPLL_CCORE uses the different parent source
> group.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Applied, thanks,
