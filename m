From: eric@anholt.net (Eric Anholt)
Date: Mon, 24 Oct 2016 09:38:59 -0700
Subject: [PATCH V7 2/6] thermal: bcm2835: add thermal driver for bcm2835
 soc
In-Reply-To: <eaff4043-5a62-da2d-cee1-9962b8c4783a@i2se.com>
References: <1474446227-1147-1-git-send-email-kernel@martin.sperl.org>
 <1474446227-1147-3-git-send-email-kernel@martin.sperl.org>
 <87twczg27x.fsf@eliezer.anholt.net>
 <eaff4043-5a62-da2d-cee1-9962b8c4783a@i2se.com>
Message-ID: <87eg35snvg.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Martin,
>
> Am 28.09.2016 um 23:10 schrieb Eric Anholt:
>> kernel at martin.sperl.org writes:
>>
>>> From: Martin Sperl <kernel@martin.sperl.org>
>>>
>>> Add basic thermal driver for bcm2835 SOC.
>>>
>>> This driver currently relies on the firmware setting up the
>>> tsense HW block and does not set it up itself.
>>>
>>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>>> Acked-by: Eric Anholt <eric@anholt.net>
>>> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
>> What's the status of merging this one?  I'd like to merge the other
>> patches.
>
> i think it's necessary to rebase the whole series. Maybe we could get it
> into 4.10.

Why would it need to be rebased?  The status, as far as I know, is that
we're still waiting for the subsystem maintainer to respond.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161024/5f37774f/attachment.sig>
