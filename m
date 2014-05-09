From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 9 May 2014 16:03:16 +0200
Subject: [PATCH] arm64: Define _TIF_POLLING_NRFLAG
In-Reply-To: <1399636665-4127-1-git-send-email-broonie@kernel.org>
References: <1399636665-4127-1-git-send-email-broonie@kernel.org>
Message-ID: <20140509140316.GU2844@laptop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 12:57:45PM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> arm64 defines TIF_POLLING_NRFLAG but not the corresponding shifted version,
> breaking the build with next-20140509 due to fd99f91aa007b (sched/idle:
> Avoid spurious wakeup IPIs) which added a reference to the shifted version
> which is present on most arches.

Sorry about that,

Acked-by: Peter Zijlstra <peterz@infradead.org>

Should I get it in -tip so borkage and fix come in through the same
tree, or what's the preferred routing?
