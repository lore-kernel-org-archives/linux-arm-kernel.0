From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 10 Sep 2014 15:53:39 +0200
Subject: [PATCH v5 06/12] sched: add per rq cpu_capacity_orig
In-Reply-To: <1409051215-16788-7-git-send-email-vincent.guittot@linaro.org>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
 <1409051215-16788-7-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140910135339.GQ3190@worktop.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 01:06:49PM +0200, Vincent Guittot wrote:
> This new field cpu_capacity_orig reflects the available capacity of a CPUs
> unlike the cpu_capacity which reflects the current capacity that can be altered
> by frequency and rt tasks.
> 

No real objection to the patch as such, but the Changelog fails to tell
us why you want this.
