From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 25 Oct 2016 13:37:26 -0700
Subject: [PATCH v2 4/4] ARM: clk: imx31: properly init clocks for
 machines with DT
In-Reply-To: <1474848223-19728-5-git-send-email-vz@mleia.com>
References: <1474848223-19728-1-git-send-email-vz@mleia.com>
 <1474848223-19728-5-git-send-email-vz@mleia.com>
Message-ID: <20161025203726.GC26139@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26, Vladimir Zapolskiy wrote:
> Clock initialization for i.MX31 powered machines with DT support
> should be done by a call of an init function registered with
> CLK_OF_DECLARE() in common clock framework.
> 
> The change converts exported mx31_clocks_init_dt() into a static
> initialization function registered by CLK_OF_DECLARE().
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
