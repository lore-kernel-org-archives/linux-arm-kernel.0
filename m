From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Wed, 9 Jul 2014 12:30:49 +0200
Subject: [PATCH v3 01/12] sched: fix imbalance flag reset
In-Reply-To: <20140709101413.GR19379@twins.programming.kicks-ass.net>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-2-git-send-email-vincent.guittot@linaro.org>
 <20140709101413.GR19379@twins.programming.kicks-ass.net>
Message-ID: <CAKfTPtAfYxxy1jg_DhdBvQzMKso2qw=8n2BktjvjQs5OAisobQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 July 2014 12:14, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Jun 30, 2014 at 06:05:32PM +0200, Vincent Guittot wrote:
>> +++ b/kernel/sched/fair.c
>> @@ -6615,10 +6615,8 @@ more_balance:
>
> In order to avoid labels being used as functions; you can use:
>
> .quiltrc:
> QUILT_DIFF_OPTS="-F ^[[:alpha:]\$_].*[^:]\$"
>
> .gitconfig:
> [diff "default"]
>         xfuncname = "^[[:alpha:]$_].*[^:]$"
>

Thanks, i'm going to add it to my .gitconfig

>
