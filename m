From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 14 Oct 2015 11:32:48 -0700
Subject: [PATCH v1 1/2] clk: samsung: exynos5250: Add DISP1 clocks
In-Reply-To: <1444819457-27519-2-git-send-email-tomeu.vizoso@collabora.com>
References: <1444819457-27519-1-git-send-email-tomeu.vizoso@collabora.com>
 <1444819457-27519-2-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20151014183248.GG26883@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14, Tomeu Vizoso wrote:
> When the DISP1 power domain is powered off, there's two clocks that need
> to be temporarily reparented to OSC, and back to their original parents
> when the domain is powered on again.
> 
> We expose these two clocks in the DT bindings so that the DT node of the
> power domain can reference them.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
