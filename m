From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 22 Aug 2013 09:28:04 +0800
Subject: [PATCH v6 01/11] irqchip: move mmp irq driver
In-Reply-To: <CAMLZHHSYqTPfo1QhRK9cfaGzE4hDk0bA5rz39PatzCSUau01ug@mail.gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
 <1374833133-21119-2-git-send-email-haojian.zhuang@gmail.com>
 <CAMLZHHTeKN7N6AsgTySE0QLHBv8yq-00C31iue_swusXnG6=uA@mail.gmail.com>
 <CAMLZHHSYqTPfo1QhRK9cfaGzE4hDk0bA5rz39PatzCSUau01ug@mail.gmail.com>
Message-ID: <CAN1soZygCecRAOVJ48+2P6cuHxCJvcQtayVK1suhc+Z4J-KBjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 4:27 AM, Daniel Drake <dsd@laptop.org> wrote:
> Hi Haojian,
>
> On Wed, Aug 14, 2013 at 3:26 PM, Daniel Drake <dsd@laptop.org> wrote:
>> This patch series affects 3 different subsystems: irqchip,
>> clocksource, clk. It's not clear from your submission who you are
>> expecting to review/merge this. Unless there is some prior agreement,
>> maybe it would be easier and clearer to divide this up by subsystem.
>> There doesn't seem to be any overlap/dependencies between the 3 parts.
>
> I haven't heard back from you on these patches. Is there anything I
> can do to help?
>
> I know these patches are blocking the 5-or-so patches I am trying to
> submit for OLPC XO support. Only one of those patches is perhaps
> calling for discussion (how to put the clocks in DT) and it is a bit
> frustrating that after two months we have still not progressed.
>
> To start with, maybe I could resend patches 1 to 5 in this series to
> the irqchip maintainers, with the review comments incorporated, adding
> the following 2 patches on at the
> end?http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/176643.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/176643.html
>
> Or any other suggestions for how I can help things move along?
>
> Thanks
> Daniel

I'll update the clock patches in this series. Since I was very busy, I
didn't have time
to handle it. I'll submit them again in this week.

IRQ & clocksource patches will go through ARM SoC. clock patches will go through
clock tree. The clocksource patches are depended on clock patches.

Regards
Haojian
