From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 27 May 2014 15:43:08 +0200
Subject: [PATCH v2 02/11] sched: remove a wake_affine condition
In-Reply-To: <1400860385-14555-3-git-send-email-vincent.guittot@linaro.org>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-3-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140527134308.GA11074@laptop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 05:52:56PM +0200, Vincent Guittot wrote:
> 
> If sync is set, it's not as straight forward as above (especially if cgroup
> are involved) 

avg load with cgroups is 'interesting' alright.
