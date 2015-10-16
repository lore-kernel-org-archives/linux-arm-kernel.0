From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Fri, 16 Oct 2015 22:02:25 +0900
Subject: [PATCH v4 2/2] arm64: Expand the stack trace feature to support
 IRQ stack
In-Reply-To: <561FCDCA.1080804@arm.com>
References: <1444231692-32722-1-git-send-email-jungseoklee85@gmail.com>
 <1444231692-32722-3-git-send-email-jungseoklee85@gmail.com>
 <5617CE26.10604@arm.com> <179A25A2-C346-46C0-93D1-BABD4B6CB401@gmail.com>
 <561FCDCA.1080804@arm.com>
Message-ID: <9A685B5F-61FA-451C-BFF4-7491E2D02AF9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 16, 2015, at 1:01 AM, James Morse wrote:
> On 15/10/15 15:24, Jungseok Lee wrote:
>> On Oct 9, 2015, at 11:24 PM, James Morse wrote:
>>> I think unwind_frame() needs to walk the irq stack too. [2] is an example
>>> of perf tracing back to userspace, (and there are patches on the list to
>>> do/fix this), so we need to walk back to the start of the first stack for
>>> the perf accounting to be correct.
>> 
>> I plan to do re-spin this series without [PATCH 2/2] since 1) Akashi's
>> approach looks better than mine and 2) you have the perf patches for [2].
> 
> They aren't my patches - the ones I saw on the list were for arm:
> https://lkml.org/lkml/2015/10/1/769 - its evidently something perf
> supports, so we shouldn't make it worse?

Aha, thanks for the information!

Best Regards
Jungseok Lee
