From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 30 May 2014 15:45:32 -0400 (EDT)
Subject: [PATCH v2 10/11] sched: move cfs task on a CPU with higher
 capacity
In-Reply-To: <CAKfTPtDWd5FKqSemFMFMMPz+t+aEnHWL_WH5grRoegtGnfD+bw@mail.gmail.com>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-11-git-send-email-vincent.guittot@linaro.org>
 <53888719.70604@arm.com>
 <CAKfTPtDWd5FKqSemFMFMMPz+t+aEnHWL_WH5grRoegtGnfD+bw@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1405301528530.17310@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 May 2014, Vincent Guittot wrote:

> On 30 May 2014 15:26, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >> +     /*
> >> +      * The group capacity is reduced probably because of activity from other
> >
> > Here 'group capacity' refers to sgs->group_power and not to
> > sgs->group_capacity, right?
> 
> yes, you're right it's cpu_power, i will correct the comment

Note that peterz applied my rename patches so sgs->group_power has 
become sgs->group_capacity.


Nicolas
