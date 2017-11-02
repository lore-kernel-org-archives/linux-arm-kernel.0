From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 1 Nov 2017 23:31:52 -0700
Subject: [PATCH] clk: make clk_init_data const
In-Reply-To: <1503050897-23252-1-git-send-email-bhumirks@gmail.com>
References: <1503050897-23252-1-git-send-email-bhumirks@gmail.com>
Message-ID: <20171102063152.GZ30645@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18, Bhumika Goyal wrote:
> Make these const as they are only stored in the init field of a clk_hw
> structure, which is const.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
