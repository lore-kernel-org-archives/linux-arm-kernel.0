From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 30 Sep 2015 15:38:29 -0700
Subject: [PATCH 1/5] ARM: sunxi: Add R8 support
In-Reply-To: <1442566130-3497-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1442566130-3497-1-git-send-email-maxime.ripard@free-electrons.com>
 <1442566130-3497-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150930223829.GG18556@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18, Maxime Ripard wrote:
> The R8 is a new Allwinner SoC based on the A13. While both are very
> similar, there's still a few differences. Introduce a new compatible to
> deal with them.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

BTW, why is the entire series sent To: Mike and I? Are these
patches intended to go through clk tree?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
