From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 25 Jun 2014 11:23:46 +1000
Subject: [PATCH v2] sched: Fix compiler warnings
In-Reply-To: <1403658329-13196-1-git-send-email-linux@roeck-us.net>
References: <1403658329-13196-1-git-send-email-linux@roeck-us.net>
Message-ID: <1403659426.4587.192.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-06-24 at 18:05 -0700, Guenter Roeck wrote:

 .../...

> Drop 'const' from the function declarations to fix the problem.
> 
> The fix for all three patches has to be applied together to avoid
> compilation failures for the affected architectures.
> 
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Fix problem in all affected architectures with a single patch
>     to avoid compilation errors.
