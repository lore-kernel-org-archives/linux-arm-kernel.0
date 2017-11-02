From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 1 Nov 2017 23:22:43 -0700
Subject: [PATCH 1/2] CLK: SPEAr: make structure field and function
 argument as const
In-Reply-To: <1508251114-7042-2-git-send-email-bhumirks@gmail.com>
References: <1508251114-7042-1-git-send-email-bhumirks@gmail.com>
 <1508251114-7042-2-git-send-email-bhumirks@gmail.com>
Message-ID: <20171102062243.GS30645@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17, Bhumika Goyal wrote:
> Make the masks field of clk_aux structure const as it do not modify the
> fields of the aux_clk_masks structure it points to.
> 
> Make the struct aux_clk_masks *aux argument of the function
> clk_register_aux as const as the argument is only stored in the masks
> field of a clk_aux structure which is now made const.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
