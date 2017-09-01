From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Sep 2017 15:55:16 -0700
Subject: [PATCH v5 4/7] clk: at91: clk-generated: create function to find
 best_diff
In-Reply-To: <4dde07bb3345d569778e7b1b5a8679bded095041.1502346448.git-series.quentin.schulz@free-electrons.com>
References: <cover.ada7bc60e0b3a0f7429afc6ea9e4869131d1b757.1502346448.git-series.quentin.schulz@free-electrons.com>
 <4dde07bb3345d569778e7b1b5a8679bded095041.1502346448.git-series.quentin.schulz@free-electrons.com>
Message-ID: <20170901225516.GF21656@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10, Quentin Schulz wrote:
> The way to find the best_diff and do the appropriate process afterwards
> can be re-used.
> 
> This patch prepares the driver for an upcoming patch that will allow
> clk_generated to determine the rate of the audio_pll.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
