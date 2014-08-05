From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 04 Aug 2014 17:01:34 -0700
Subject: [PATCH v8 03/10] clocksource: arm_arch_timer: change clocksource
 name if CP15 unavailable
In-Reply-To: <1407003407-31219-4-git-send-email-nathan_lynch@mentor.com>
References: <1407003407-31219-1-git-send-email-nathan_lynch@mentor.com>
 <1407003407-31219-4-git-send-email-nathan_lynch@mentor.com>
Message-ID: <53E01EDE.9040806@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/14 11:16, Nathan Lynch wrote:
> The arm and arm64 VDSOs need CP15 access to the architected counter.
> If this is unavailable (which is allowed by ARM v7), indicate this by
> changing the clocksource name to "arch_mem_counter" before registering
> the clocksource.
>
> Suggested by Stephen Boyd.
>
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
