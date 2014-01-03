From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 02 Jan 2014 16:46:16 -0800
Subject: [PATCH 1/2] seqlock: Use raw_ prefix instead of _no_lockdep
In-Reply-To: <1388704274-5278-1-git-send-email-john.stultz@linaro.org>
References: <52C5E675.80701@linaro.org>
 <1388704274-5278-1-git-send-email-john.stultz@linaro.org>
Message-ID: <52C60858.6080404@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/14 15:11, John Stultz wrote:
> Linus disliked the _no_lockdep() naming, so instead
> use the more-consistent raw_* prefix to the non-lockdep
> enabled seqcount methods.
>
> This also adds raw_ methods for the write operations
> as well, which will be utilized in a following patch.
>
> Cc: Krzysztof Ha?asa <khalasa@piap.pl>
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Willy Tarreau <w@1wt.eu>
> Cc: Ingo Molnar <mingo@kernel.org>,
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
