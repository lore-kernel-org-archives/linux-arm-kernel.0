From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 15 Aug 2016 12:10:22 -0700
Subject: [PATCH v1 01/14] clk: twl6040: Correct clk_ops
In-Reply-To: <20160530085522.30398-2-peter.ujfalusi@ti.com>
References: <20160530085522.30398-1-peter.ujfalusi@ti.com>
 <20160530085522.30398-2-peter.ujfalusi@ti.com>
Message-ID: <20160815191022.GW361@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30, Peter Ujfalusi wrote:
> Since the drover only supports prepare callbacks, the use of is_enabled is
> not correct, it should be handling is_prepared.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
