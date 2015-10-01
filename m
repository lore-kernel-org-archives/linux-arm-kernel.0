From: hzpeterchen@gmail.com (Peter Chen)
Date: Thu, 1 Oct 2015 18:51:19 +0800
Subject: [RESEND PATCH v2 2/2] ARM: imx6: change default burst size for USB
In-Reply-To: <1443688950.8574.7.camel@pengutronix.de>
References: <1443579437-845-1-git-send-email-peter.chen@freescale.com>
 <1443579437-845-2-git-send-email-peter.chen@freescale.com>
 <1443603159.3185.5.camel@pengutronix.de>
 <CAL411-p-V=p8g9ckxewNzZ7kG+ChbgewSn8V8n1kmw7DqU0hZw@mail.gmail.com>
 <1443688950.8574.7.camel@pengutronix.de>
Message-ID: <CAL411-qf7H=4OkgrUXUVkvFc3QSuSLJ2ioGCeVJ0bqF9jLa3qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 1, 2015 at 4:42 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Donnerstag, den 01.10.2015, 16:13 +0800 schrieb Peter Chen:
>> On Wed, Sep 30, 2015 at 4:52 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
>> > Am Mittwoch, den 30.09.2015, 10:17 +0800 schrieb Peter Chen:
>> >> It can improve the USB performance when choosing larger
>> >> burst size at some systems (bus size is larger), there is
>> >> no side effect if this burst size is larger than bus size.
>> >>
>> > Just for the record, as it seems too late to stop the train now:
>> >
>> > I am _NOT_ happy that the extended binding has been accepted into the
>> > USB tree despite outstanding review comments from me not being addressed
>> > or even answered.
>> >
>>
>> I sent patch for review at Aug 7th, queued this patches at Aug 13th
>> [1], and sent pull
>> request at Aug 14th, I am curious why you did not give comments
>> between this period utill
>> I complained one ethernet patch breaks i.mx ethernet function for v4.2
>> tree [2] at Aug 14th.
>>
> What do the USB changes have to do with any ethernet changes?
>
> The comments I'm referring to are from Aug 14th
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/364396.html
>
> So you are telling me that giving reviewers not even a week before
> sending the pull request is appropriate? And that sending the pull
> despite there being open review comments is ok? Think again.
>

Comments are welcome at anytime, but why you are __NOT__ happy it
was accepted and your comments were delayed. If you think this binding
description is not ok, patch is welcome.

>> I will consider your comments, and send patch for improving it if possible.
>>
> As I said it may be too late now. By sending the pull request including
> the binding change you forced everyone to now either accept the (in my
> opinion not really perfect) binding, or hurry to change it in the
> current RC phase, something which I'm not comfortable with. The damage
> has been done.
>

Again, I waited one week, and your comments were late. I do not want
to dispute more at our holidays. Let's stop here.

-- 
BR,
Peter Chen
