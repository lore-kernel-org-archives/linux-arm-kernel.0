From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 23 Nov 2016 11:57:45 -0800
Subject: [PATCH] clk: bcm2835: Fix ->fixed_divider of pllh_aux
In-Reply-To: <20161122204528.18435-1-eric@anholt.net>
References: <20161122204528.18435-1-eric@anholt.net>
Message-ID: <20161123195745.GH25626@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22, Eric Anholt wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> There is no fixed divider on pllh_aux.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Reviewed-by: Eric Anholt <eric@anholt.net>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
