From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Wed, 19 Mar 2014 13:30:26 +0100
Subject: [PATCH v2 7/7] sched: powerpc: Add SD_SHARE_POWERDOMAIN for SMT
 level
In-Reply-To: <20140319120555.GL27632@laptop.programming.kicks-ass.net>
References: <1395165409-18055-1-git-send-email-vincent.guittot@linaro.org>
 <1395165409-18055-8-git-send-email-vincent.guittot@linaro.org>
 <20140319120555.GL27632@laptop.programming.kicks-ass.net>
Message-ID: <CAKfTPtAMVoZbdqafwCmU3mGeO+UiXEamtwqF-MMLsEqQnSc8FQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 March 2014 13:05, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Mar 18, 2014 at 06:56:49PM +0100, Vincent Guittot wrote:
>> Set the power domain dependency at SMT level of Power8 but keep the flag
>> clear at CPU level. The goal is to consolidate tasks on the threads of a
>> core up to a level as decribed in the link below:
>> https://lkml.org/lkml/2014/3/12/16
>
> I've not yet looked at the link; but its best to avoid references and
> have a Changelog that can stand on its own.

I can copy/paste Preeti's explanation in the commit message

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
