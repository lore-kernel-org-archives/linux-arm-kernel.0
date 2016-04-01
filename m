From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Apr 2016 12:28:39 -0700
Subject: [PATCH 2/3] clk: ti: amx3xx: limit the maximum frequency of
 DPLLs based on spec
In-Reply-To: <1458158097-21137-3-git-send-email-t-kristo@ti.com>
References: <1458158097-21137-1-git-send-email-t-kristo@ti.com>
 <1458158097-21137-3-git-send-email-t-kristo@ti.com>
Message-ID: <20160401192839.GW18567@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16, Tero Kristo wrote:
> AM33xx/AM43xx devices use the same DPLL IP blocks, which only support
> maximum rate of 1GHz [1] for the default and 2GHz for the low-jitter type
> DPLLs [2]. Reflect this limitation in the DPLL init code by adding the
> max-rate parameter based on the DPLL types.
> 
> [1] Functional, integration & test specification for GS70 ADPLLS, Rev 1.0-01
> [2] Functional, integration & test specification for GS70 ADPLLLJ, Rev 0.8-02
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Lokesh Vutla <lokeshvutla@ti.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Or I can apply these two targeting 4.7 if you like.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
