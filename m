From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 28 Oct 2013 09:19:40 -0700
Subject: [PATCH 1/2] clockevent: sun4i: Fill the irq field in the
 clockevent structure
In-Reply-To: <1382699771-4396-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1382699771-4396-1-git-send-email-maxime.ripard@free-electrons.com>
 <1382699771-4396-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <526E8E9C.2010304@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/13 04:16, Maxime Ripard wrote:
> The clock event structure irq field was not filled previously to the
> interrupt we're using.
>
> This was resulting in the timer not being used at all when using a
> configuration with SMP enabled on a system with several CPUs, and with
> the cpumask set to the cpu_possible_mask.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
