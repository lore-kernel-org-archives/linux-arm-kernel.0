From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Jul 2014 10:21:21 +0100
Subject: [PATCH 1/1] arm: perf: Fix build error
In-Reply-To: <1404291976-24662-1-git-send-email-sachin.kamat@samsung.com>
References: <1404291976-24662-1-git-send-email-sachin.kamat@samsung.com>
Message-ID: <20140702092120.GC18731@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sachin,

On Wed, Jul 02, 2014 at 10:06:16AM +0100, Sachin Kamat wrote:
> Add missing semicolon to fix the following build errors introduced by
> commit 6f73e8ababdd ("arm: perf: clean up PMU names"):
> arch/arm/kernel/perf_event_v6.c:498:2: error: expected ?;? before ?return?
> arch/arm/kernel/perf_event_v6.c:505:2: error: expected ?;? before ?return?
> arch/arm/kernel/perf_event_v6.c:512:2: error: expected ?;? before ?return?
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Thanks for this, I'll fold it in with the original patch.

Mark: can you test this on v6 please, preferably with Vince's fuzzer?

Will
