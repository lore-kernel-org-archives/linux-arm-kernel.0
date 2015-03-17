From: eric@anholt.net (Eric Anholt)
Date: Tue, 17 Mar 2015 12:04:13 -0700
Subject: [PATCH 3/4 v4] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <20150317180517.GD3318@x1>
References: <1426213936-4139-1-git-send-email-eric@anholt.net>
 <1426213936-4139-3-git-send-email-eric@anholt.net>
 <5507A095.5090805@wwwdotorg.org> <20150317180517.GD3318@x1>
Message-ID: <87zj7bla36.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lee Jones <lee.jones@linaro.org> writes:

> On Mon, 16 Mar 2015, Stephen Warren wrote:
>
>> On 03/12/2015 08:32 PM, Eric Anholt wrote:
>> > From: Lubomir Rintel <lkundrak@v3.sk>
>> > 
>> > Implement BCM2835 mailbox support as a device registered with the
>> > general purpose mailbox framework. Implementation based on commits by
>> > Lubomir Rintel [1], Suman Anna and Jassi Brar [2] on which to base the
>> > implementation.
>> > 
>> > [1] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-April/000528.html
>> > [2] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-May/000546.html
>> > 
>> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>> > Signed-off-by: Craig McGeachie <slapdau@yahoo.com.au>
>> > Signed-off-by: Suman Anna <s-anna@ti.com>
>> > Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
>> > Signed-off-by: Eric Anholt <eric@anholt.net>
>> > Cc: Jassi Brar <jassisinghbrar@gmail.com>
>> > Acked-by: Lee Jones <lee.jones@linaro.org>
>> 
>> Acks often don't carry over when there are significant changes.
>
> Did I even Ack this?

Yeah, I don't see any record of it, looks like I misread the mail
thread.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150317/68198f4c/attachment.sig>
