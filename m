From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Sep 2016 14:24:01 -0700
Subject: [PATCH] clk: nxp: clk-lpc32xx: Unmap region obtained by of_iomap
In-Reply-To: <1474368846-15916-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1474368846-15916-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <20160921212401.GN8319@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20, Arvind Yadav wrote:
> From: Arvind Yadav <arvind.yadav.cs@gmail.com>
> 
> Free memory mapping, if lpc32xx_clk_init is not successful.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
