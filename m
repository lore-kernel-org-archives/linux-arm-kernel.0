From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Jul 2015 15:51:43 -0700
Subject: [PATCH v2 3/9] clk: rockchip: protect register macros against
 multipart values
In-Reply-To: <1434637116-17124-4-git-send-email-heiko@sntech.de>
References: <1434637116-17124-1-git-send-email-heiko@sntech.de>
 <1434637116-17124-4-git-send-email-heiko@sntech.de>
Message-ID: <20150702225143.GM4301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18, Heiko Stuebner wrote:
> The macros calculate the correct offset from the id in the parameter.
> If this parameter does not consist of a single number, the calculation
> will return wrong registers in the best case or create unaligned accesses
> in the worst case. So protect the calculations against such values.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

Applied to clk-rk3368

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
