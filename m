From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 1 Nov 2017 23:31:50 -0700
Subject: [PATCH] clk: imx: make clk_ops const
In-Reply-To: <1503407909-15469-1-git-send-email-bhumirks@gmail.com>
References: <1503407909-15469-1-git-send-email-bhumirks@gmail.com>
Message-ID: <20171102063150.GY30645@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22, Bhumika Goyal wrote:
> Make these const as they are only stored in the const field of a
> clk_init_data structure.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
