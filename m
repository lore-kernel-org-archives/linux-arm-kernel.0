From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 30 Aug 2017 22:39:06 -0700
Subject: [PATCH] clk: versatile: make clk_ops const
In-Reply-To: <1503410786-25519-1-git-send-email-bhumirks@gmail.com>
References: <1503410786-25519-1-git-send-email-bhumirks@gmail.com>
Message-ID: <20170831053906.GD21656@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22, Bhumika Goyal wrote:
> Make this const as it is only stored in the const field of a
> clk_init_data structure.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
