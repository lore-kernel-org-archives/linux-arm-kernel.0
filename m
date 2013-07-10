From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 10 Jul 2013 13:58:39 +0800
Subject: [PATCH V3 2/3] clocksource: mmp: support CLOCKSOURCE OF DECLARE
In-Reply-To: <201307092316.20905.arnd@arndb.de>
References: <1373352166-10064-1-git-send-email-zhangwm@marvell.com>
 <1373352166-10064-3-git-send-email-zhangwm@marvell.com>
 <20130709181434.76f6216d@skate> <201307092316.20905.arnd@arndb.de>
Message-ID: <CAN1soZyFztVR1XSw9bDS5JexK0Mdbpr6yevatVf+MnBohwCj1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 10, 2013 at 5:16 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 09 July 2013, Thomas Petazzoni wrote:
>> Dear Neil Zhang,
>>
>> On Tue, 9 Jul 2013 14:42:45 +0800, Neil Zhang wrote:
>> > support CLOCKSOURCE OF DECLARE for mmp timer.
>> >
>> > Signed-off-by: Neil Zhang <zhangwm@marvell.com>
>> > ---
>> >  arch/arm/mach-mmp/mmp-dt.c  |    5 ++---
>> >  arch/arm/mach-mmp/mmp2-dt.c |    3 +--
>> >  arch/arm/mach-mmp/time.c    |   15 ++-------------
>> >  3 files changed, 5 insertions(+), 18 deletions(-)
>>
>> Maybe it would be good to take this opportunity to move
>> arch/arm/mach-mmp/time.c into drivers/clocksource/.
>
> +1
>
> Or we might want to have a more coordinated move of all clocksource
> drivers in arch/arm to drivers/clocksource now, as we have done for some
> other subsystems.
>
>         Arnd

I already sent some patches on this. But I didn't get response yet. I'll rebase
them and send them again. I hope that they could be merged in this cycle.

Regards
Haojian
