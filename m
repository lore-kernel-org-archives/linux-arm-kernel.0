From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 10 Oct 2014 09:18:23 +0200
Subject: [PATCH v7 6/7] sched: replace capacity_factor by usage
In-Reply-To: <CAKfTPtCQzdDuNmifU3sobqSke0Mri0jDVpJTwuKytaNs_RLM1w@mail.gmail.com>
References: <1412684017-16595-1-git-send-email-vincent.guittot@linaro.org>
 <1412684017-16595-7-git-send-email-vincent.guittot@linaro.org>
 <20141009121643.GQ4750@worktop.programming.kicks-ass.net>
 <CAKfTPtCX687FkGgxLO7spfGvDxhDWeFDERLRZ-NakO2Jrpmnhw@mail.gmail.com>
 <20141009151820.GX10832@worktop.programming.kicks-ass.net>
 <CAKfTPtCQzdDuNmifU3sobqSke0Mri0jDVpJTwuKytaNs_RLM1w@mail.gmail.com>
Message-ID: <CAKfTPtATuTWSU+R289Q8qpVR4b+D1HdrKjKHZNz7b_ahAiWOWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 October 2014 09:17, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> yes i think it latter because it give a more stable view of the

s/latter/matter/

> "overload state" and "have  free capacity state" of the CPU.
> One additional point is that the imbalance_pct will ensure that a
> cpu/group will not been seen as having capacity if its available
> capacity is only 1-5% which will generate spurious task migration
>
> I will add these details in the commit log and in a comment in the code
