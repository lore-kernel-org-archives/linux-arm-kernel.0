From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 3 Oct 2014 17:14:51 +0200
Subject: [PATCH v6 3/6] sched: add utilization_avg_contrib
In-Reply-To: <CAKfTPtDvX=JFf6OBBzTVbo6C76p243za+9CkL-ofSOvHQS5-mQ@mail.gmail.com>
References: <1411488485-10025-1-git-send-email-vincent.guittot@linaro.org>
 <1411488485-10025-4-git-send-email-vincent.guittot@linaro.org>
 <20141003143634.GL2849@worktop.programming.kicks-ass.net>
 <CAKfTPtDvX=JFf6OBBzTVbo6C76p243za+9CkL-ofSOvHQS5-mQ@mail.gmail.com>
Message-ID: <20141003151451.GJ10583@worktop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 03, 2014 at 04:51:01PM +0200, Vincent Guittot wrote:
> On 3 October 2014 16:36, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> >> +      * utilization_load_avg is the sum of the average running time of the
> >> +      * sched_entities on the rq.
> >>        */
> >
> > So I think there was some talk about a blocked_utilization thingy, which
> > would track the avg running time of the tasks currently asleep, right?
> >
> 
> yes. Do you mean that we should anticipate and rename
> utilization_load_avg into utilization_runnable_avg to make space for a
> utilization_blocked_avg that could be added in future ?

nah, just trying to put things straight in my brain, including what is
'missing'.
