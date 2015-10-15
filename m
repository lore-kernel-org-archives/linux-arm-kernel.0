From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 15 Oct 2015 12:53:16 -0700
Subject: [PATCH v3 3/5] clk: qoriq: Add ls2080a support.
In-Reply-To: <1442723397-26329-4-git-send-email-scottwood@freescale.com>
References: <1442723397-26329-1-git-send-email-scottwood@freescale.com>
 <1442723397-26329-4-git-send-email-scottwood@freescale.com>
Message-ID: <20151015195316.GS4558@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19, Scott Wood wrote:
> LS2080A is the first implementation of the chassis 3 clockgen, which
> has a different register layout than previous chips.  It is also little
> endian, unlike previous chips.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
