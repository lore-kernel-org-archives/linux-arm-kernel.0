From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 18 Apr 2014 13:39:04 +0200
Subject: [PATCH] fix: sched: rework of sched_domain topology definition
In-Reply-To: <1397820846-32603-1-git-send-email-vincent.guittot@linaro.org>
References: <20140418105601.GU11182@twins.programming.kicks-ass.net>
 <1397820846-32603-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140418113904.GW11182@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 18, 2014 at 01:34:06PM +0200, Vincent Guittot wrote:
> fix missing change from int to pointer function for numa flags
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks, folded it into the original patch.
