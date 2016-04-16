From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 Apr 2016 17:26:38 -0700
Subject: [PATCH 1/3] clk: ti: dpll: add support for specifying max rate
 for DPLLs
In-Reply-To: <1458158097-21137-2-git-send-email-t-kristo@ti.com>
References: <1458158097-21137-1-git-send-email-t-kristo@ti.com>
 <1458158097-21137-2-git-send-email-t-kristo@ti.com>
Message-ID: <20160416002638.GG26353@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16, Tero Kristo wrote:
> DPLLs typically have a maximum rate they can support, and this varies
> from DPLL to DPLL. Add support of the maximum rate value to the DPLL
> data struct, and also add check for this in the DPLL round_rate function.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Lokesh Vutla <lokeshvutla@ti.com>
> ---

Applied to clk-next with some munging for clk_hw_get_rate()

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
