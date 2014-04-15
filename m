From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 15 Apr 2014 09:53:10 +0200
Subject: [PATCH v4 0/5] rework sched_domain topology description
In-Reply-To: <534937F0.3020702@arm.com>
References: <1397209481-28542-1-git-send-email-vincent.guittot@linaro.org>
 <534937F0.3020702@arm.com>
Message-ID: <20140415075310.GI11182@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 12, 2014 at 01:56:16PM +0100, Dietmar Eggemann wrote:
> On 11/04/14 10:44, Vincent Guittot wrote:
> >This patchset was previously part of the larger tasks packing patchset [1].
> >I have splitted the latter in 3 different patchsets (at least) to make the
> >thing easier.
> >-configuration of sched_domain topology (this patchset)
> >-update and consolidation of cpu_power
> >-tasks packing algorithm
> >
> >Based on Peter Z's proposal [2][3], this patchset modifies the way to configure
> >the sched_domain level in order to let architectures to add specific level like
> >the current BOOK level or the proposed power gating level for ARM architecture.
> >
> >[1] https://lkml.org/lkml/2013/10/18/121
> >[2] https://lkml.org/lkml/2013/11/5/239
> >[3] https://lkml.org/lkml/2013/11/5/449
> 
> Hi Vincent,
> 
> given the discussion we had for v1-v3 and a short boot test of v4:
> 
> For patch 1/5, 4/5, 5/5 on ARM TC2 (heterogeneous dual socket w/o SMT
> machine):
> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thanks guys!
