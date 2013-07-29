From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Mon, 29 Jul 2013 11:15:07 +0100
Subject: [RFC][PATCH 1/2] ARM64: add cpu topology definition
In-Reply-To: <CAKfTPtBpo41LJ3V8TB8YwudwqpURuA2u_Lvu4KYVK=qSs+gFuQ@mail.gmail.com>
References: <1374921728-9007-1-git-send-email-hanjun.guo@linaro.org>
 <CAKfTPtBpo41LJ3V8TB8YwudwqpURuA2u_Lvu4KYVK=qSs+gFuQ@mail.gmail.com>
Message-ID: <51F640AB.2050709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/07/13 10:46, Vincent Guittot wrote:
> On 27 July 2013 12:42, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> Power aware scheduling needs the cpu topology information to improve the
>> cpu scheduler decision making.
> 
> It's not only power aware scheduling. The scheduler already uses
> topology and cache sharing when  CONFIG_SCHED_MC and/or
> CONFIG_SCHED_SMT are enable. So you should also add these configs for
> arm64 so the scheduler can use it
> 
Just for my knowledge, I thought power aware using SCHED_MC/SMT was
removed. I see commit 8e7fbcbc22c12414bcc9dfdd683637f58fb32759 "sched:
Remove stale power aware scheduling remnants and dysfunctional knobs"
I may be missing something here.

Regards,
Sudeep
