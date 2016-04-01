From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Apr 2016 12:27:50 -0700
Subject: [PATCH 1/3] clk: ti: dpll: add support for specifying max rate
 for DPLLs
In-Reply-To: <1458158097-21137-2-git-send-email-t-kristo@ti.com>
References: <1458158097-21137-1-git-send-email-t-kristo@ti.com>
 <1458158097-21137-2-git-send-email-t-kristo@ti.com>
Message-ID: <20160401192750.GV18567@codeaurora.org>
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

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
