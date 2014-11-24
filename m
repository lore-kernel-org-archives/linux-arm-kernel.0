From: kernellwp@gmail.com (Wanpeng Li)
Date: Mon, 24 Nov 2014 08:34:11 +0800
Subject: [PATCH v2 09/11] sched: test the cpu's capacity in wake affine
In-Reply-To: <CAKfTPtAvFEmAmPMQsEN-=ftudQwd0fHOxq4MRs3HDyHYjLPGZQ@mail.gmail.com>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-10-git-send-email-vincent.guittot@linaro.org>
 <20140528105855.GR30445@twins.programming.kicks-ass.net>
 <CAKfTPtAvFEmAmPMQsEN-=ftudQwd0fHOxq4MRs3HDyHYjLPGZQ@mail.gmail.com>
Message-ID: <54727D03.4090909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vincent,
On 5/28/14, 7:15 PM, Vincent Guittot wrote:
> On 28 May 2014 12:58, Peter Zijlstra <peterz@infradead.org> wrote:
>> On Fri, May 23, 2014 at 05:53:03PM +0200, Vincent Guittot wrote:
[snip]
>> Now I'm only struggling to understand the rationale for this, its got
>> LLC in there somewhere, but I'm failing to comprehend.
> Ah.. i have probably overestimated the fact that wake_affine was only
> done at MC or SMT level but after reading more deeply the glags
> configuration of all  sched_domain level , my assumption is not true.

What's level the wake_affine should happen?

Regards,
Wanpeng Li

> So I need to test sd flag to make sure that their share their cache at
> this level
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
