From: sboyd@codeaurora.org (spamassassin system account)
Date: Wed, 21 Oct 2015 17:02:30 -0700
Subject: [PATCH v3 05/10] clk: iproc: Add PLL base write function
In-Reply-To: <1444938513-10758-6-git-send-email-jonmason@broadcom.com>
References: <1444938513-10758-1-git-send-email-jonmason@broadcom.com>
 <1444938513-10758-6-git-send-email-jonmason@broadcom.com>
Message-ID: <20151022000230.GS19782@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15, Jon Mason wrote:
> All writes to the PLL base address must be flushed if the
> IPROC_CLK_NEEDS_READ_BACK flag is set.  If we add a function to make the
> necessary write and reads, we can make sure that any future code which
> makes PLL base writes will do the correct thing.
> 
> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> ---

Applied to clk-iproc

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
