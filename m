From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 2 Jun 2017 15:41:53 -0700
Subject: [PATCH] clk: bcm2835: Correct the prediv logic
In-Reply-To: <20170515173504.11337-1-eric@anholt.net>
References: <20170515173504.11337-1-eric@anholt.net>
Message-ID: <20170602224153.GZ20170@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15, Eric Anholt wrote:
> From: Phil Elwell <phil@raspberrypi.org>
> 
> If a clock has the prediv flag set, both the integer and fractional
> parts must be scaled when calculating the resulting frequency.
> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
