From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 1 Nov 2016 17:32:50 -0700
Subject: [PATCH] clk: nxp: clk-lpc18xx-ccu: Unmap region obtained by
 of_iomap
In-Reply-To: <1474367987-15808-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1474367987-15808-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <20161102003250.GI16026@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20, Arvind Yadav wrote:
> From: Arvind Yadav <arvind.yadav.cs@gmail.com>
> 
> Free memory mapping, if lpc18xx_ccu_init is not successful.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
