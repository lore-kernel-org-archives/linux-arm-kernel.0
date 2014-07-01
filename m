From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 01 Jul 2014 10:40:46 -0700
Subject: [PATCH 8/8] arm: perf: krait: stop using singleton PMU
In-Reply-To: <1404227478-9645-9-git-send-email-mark.rutland@arm.com>
References: <1404227478-9645-1-git-send-email-mark.rutland@arm.com>
 <1404227478-9645-9-git-send-email-mark.rutland@arm.com>
Message-ID: <53B2F29E.5030403@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/14 08:11, Mark Rutland wrote:
> Currently the krait_pmu_{enable,disable}_event functions use the global
> cpu_pmu variable while all the other pmu enable/disable functions
> derive this from the event argument.
>
> This patch brings the Krait functions into line with the rest of the PMU
> backends by deriving the address of the pmu from the event argument.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
