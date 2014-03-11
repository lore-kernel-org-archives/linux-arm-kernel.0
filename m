From: olof@lixom.net (Olof Johansson)
Date: Mon, 10 Mar 2014 19:52:01 -0700
Subject: [GIT PULL 5/6] Samsung PM updates for v3.15
In-Reply-To: <01d001cf3ccc$39f339b0$add9ad10$@samsung.com>
References: <8259832.260591393840570438.JavaMail.weblogic@epml16>
 <20140309183523.GD22881@quad.lixom.net>
 <531CFA28.9020600@gmail.com>
 <CAOesGMiqhVk6JYhx=4446E1ZFWy7CrQNsjp8U6jf_De8FzidFw@mail.gmail.com>
 <01d001cf3ccc$39f339b0$add9ad10$@samsung.com>
Message-ID: <CAOesGMiYJa7uM21ot_h6mGRTQX+HLcOsmTjk78WS0KZD6=piyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 10, 2014 at 6:50 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Olof Johansson wrote:
>>
>> >> Hi,
>> >>
>> >> I don't see a single cc or acked-by line from Mike Turquette here. I'll
>> >> hold
>> >> off until he's had a chance to take a look at these ones; I suspect
>> >> they'll be
>> >> fine since it's mostly code refactoring though.
>> >
>> >
>> > I guess I should have ACKed them too, but it felt kind of strange to ACK
>> my
>> > own patches. ;)
>> >
>> > Anyway, for all samsung-clk patches:
>> >
>> > Acked-by: Tomasz Figa <t.figa@samsung.com>
>>
>> Yeah, self-acking doesn't make much sense. :)
>>
>> I'm mostly worried about patches touching other subsystems without the
>> other maintainer being aware of it or having reviewed them. As I said,
>> these mostly look like refactorings but it's still good habit.
>>
> OK, agreed, I think Mike knew about that though. Let's wait for Mike's
> response.
>
> BTW, should I sort out the branch again if Mike gives ack on that?

If I hear from Mike that he's OK with it then I can merge it, no need to rebase.


-Olof
