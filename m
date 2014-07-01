From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Jul 2014 19:06:59 +0100
Subject: [PATCH 8/8] arm: perf: krait: stop using singleton PMU
In-Reply-To: <1404227478-9645-9-git-send-email-mark.rutland@arm.com>
References: <1404227478-9645-1-git-send-email-mark.rutland@arm.com>
 <1404227478-9645-9-git-send-email-mark.rutland@arm.com>
Message-ID: <20140701180659.GZ28164@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 04:11:18PM +0100, Mark Rutland wrote:
> Currently the krait_pmu_{enable,disable}_event functions use the global
> cpu_pmu variable while all the other pmu enable/disable functions
> derive this from the event argument.
> 
> This patch brings the Krait functions into line with the rest of the PMU
> backends by deriving the address of the pmu from the event argument.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
