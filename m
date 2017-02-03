From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 3 Feb 2017 11:55:26 -0800
Subject: [PATCH 2/2] clk: uniphier: add eMMC clock for LD11 and LD20 SoCs
In-Reply-To: <1485610021-9905-2-git-send-email-yamada.masahiro@socionext.com>
References: <1485610021-9905-1-git-send-email-yamada.masahiro@socionext.com>
 <1485610021-9905-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170203195526.GC25384@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28, Masahiro Yamada wrote:
> Add clock for the Cadence eMMC controller on LD11/LD20.
> For the other SoCs, the clock for the eMMC controller is included
> in the MIO/SD control block.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
