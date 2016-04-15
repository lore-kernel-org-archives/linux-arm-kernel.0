From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 Apr 2016 15:29:11 -0700
Subject: [PATCH v3 05/19] dt-bindings: clk: sun5i: add DRAM gates
 compatible
In-Reply-To: <1458751122-23976-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
 <1458751122-23976-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160415222911.GR14441@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23, Maxime Ripard wrote:
> The Allwinner SoCs have a gate controller to gate the access to the DRAM
> clock to the some devices that need to access the DRAM directly (mostly
> display / image related IPs).
> 
> Use a simple gates driver to support the one found in the A13 / R8 SoCs.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
