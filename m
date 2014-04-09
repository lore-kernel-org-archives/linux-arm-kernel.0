From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 9 Apr 2014 20:25:53 +0200
Subject: current->sched_class->yield_task is NULL, any hint?
In-Reply-To: <CAF1ivSbZKbDc+rzd+CUqCzNmSgZmZTE-QeSU-2WmSiuEs-Kw_w@mail.gmail.com>
References: <CAF1ivSbZKbDc+rzd+CUqCzNmSgZmZTE-QeSU-2WmSiuEs-Kw_w@mail.gmail.com>
Message-ID: <20140409182553.GE10526@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 10:43:32AM -0700, Lin Ming wrote:
> Hi Peter,
> 
> I hit a panic in sys_sched_yield() because(for some unknown reason)
> current->sched_class->yield_task is NULL.
> It's an ARM embedded board with 3.4-rt kernel.
> 
> Could you share any hint for the possible causes?

What class does current->sched_class point to?
