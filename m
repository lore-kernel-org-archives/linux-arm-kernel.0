From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Sep 2016 11:47:38 -0700
Subject: [PATCH] clk: mediatek: clk-mt8173: Unmap region obtained by
 of_iomap
In-Reply-To: <1474360242-15126-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1474360242-15126-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <20160921184738.GL8319@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20, Arvind Yadav wrote:
> From: Arvind Yadav <arvind.yadav.cs@gmail.com>
> 
> Free memory mapping, if init is not successful.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
