From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Thu, 23 Aug 2012 13:23:56 +0900
Subject: [PATCH 1/4] ARM: export read_current_timer
In-Reply-To: <20120822175810.GT9093@mudshark.cambridge.arm.com>
References: <1345645780-2749-1-git-send-email-arnd@arndb.de>
 <1345645780-2749-2-git-send-email-arnd@arndb.de>
 <503513A2.1030002@codeaurora.org>
 <20120822174945.GS9093@mudshark.cambridge.arm.com>
 <50351D80.6010600@codeaurora.org>
 <20120822175810.GT9093@mudshark.cambridge.arm.com>
Message-ID: <5035B05C.4020104@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/23/2012 2:58 AM, Will Deacon wrote:
> On Wed, Aug 22, 2012 at 06:57:20PM +0100, Stephen Boyd wrote:
>> On 08/22/12 10:49, Will Deacon wrote:
>>> On the topic of the timer stuff: Shinya/Stephen, did you have a chance to
>>> look at the registration stuff that was proposed? I'm happy to push it if
>>> people will actually use it.
>>
>> Yes I have tested it on our internal trees and it looks good. I plan to
>> send a patch to move MSM's timers over to it later this week so that we
>> have at least two users upstream.

And I think other A9 MPcore platforms, namely OMAP and EXYNOS, would
also be candidates, who tried to skip calibrate_delay() in the past
(OMAP) or currently provide non-smp_twd timers as localtimers (EXYNOS).
I may miss the latest status of those BSPs, but believe that we would
have more users (>2) in the future.

> Awesome, I'll dust that series off at -rc3 then.

It works for me for weeks without troubles, looking forward to it.
--
Shinya Kuribayashi
Renesas Electronics
