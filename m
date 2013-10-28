From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 28 Oct 2013 09:19:51 -0700
Subject: [PATCH 2/2] clocksource: sun4i: change CPU mask to
 cpu_possible_mask
In-Reply-To: <1382699771-4396-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1382699771-4396-1-git-send-email-maxime.ripard@free-electrons.com>
 <1382699771-4396-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <526E8EA7.2050801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/13 04:16, Maxime Ripard wrote:
> The interrupt for the timer is a shared processor interrupt, so any CPU
> found in the system can handle it. Switch to our cpumask to
> cpu_possible_mask instead of cpumask_of(0).
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
