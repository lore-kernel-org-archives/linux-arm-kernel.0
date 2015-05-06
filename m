From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 5 May 2015 22:56:53 -0700
Subject: [PATCH v2 0/8] clk: Minor cleanups
In-Reply-To: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
References: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20150506055653.GF10871@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28, Krzysztof Kozlowski wrote:
> Hi,
> 
> 
> Changes since v1
> ================
> 1. Rebase on next-20150427 and Sascha Hauer's:
>    clk: make strings in parent name arrays const [1]
> 2. Add patch "clk: tegra: Fix inconsistent indenting".
> 
> 
> Description and dependencies
> ============================
> Small cleanups for different clock drivers.
> 
> The first three patches are independent.
> 
> Rest of the patches (these related to constifying parent names,
> including the change for MIPS) depend on the "clk: make strings in
> parent name arrays const" from Sascha Hauer [1].
> 
> 
> Tested on Arndale Octa (Exynos5420) and Trats2 (Exynos4412). Other
> drivers (and MIPS related) only compile tested plus some static
> checkers.
> 
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg413763.html
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (8):
>   clk: rockchip: Staticize file-scope declarations
>   clk: exynos: Staticize file-scope declarations
>   clk: tegra: Fix inconsistent indenting
>   clk: tegra: Fix duplicate const for parent names
>   clk: cdce706: Constify parent names in clock init data
>   clk: sirf: Constify parent names in clock init data
>   clk: ls1x: Fix duplicate const for parent names
>   MIPS: Alchemy: Remove unneeded cast removing const

Applied 1,2,5,6,7 to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
