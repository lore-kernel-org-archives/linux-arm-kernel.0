From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 24 Oct 2016 18:21:17 +0200
Subject: [PATCH V7 2/6] thermal: bcm2835: add thermal driver for bcm2835
 soc
In-Reply-To: <87twczg27x.fsf@eliezer.anholt.net>
References: <1474446227-1147-1-git-send-email-kernel@martin.sperl.org>
 <1474446227-1147-3-git-send-email-kernel@martin.sperl.org>
 <87twczg27x.fsf@eliezer.anholt.net>
Message-ID: <eaff4043-5a62-da2d-cee1-9962b8c4783a@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

Am 28.09.2016 um 23:10 schrieb Eric Anholt:
> kernel at martin.sperl.org writes:
>
>> From: Martin Sperl <kernel@martin.sperl.org>
>>
>> Add basic thermal driver for bcm2835 SOC.
>>
>> This driver currently relies on the firmware setting up the
>> tsense HW block and does not set it up itself.
>>
>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>> Acked-by: Eric Anholt <eric@anholt.net>
>> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> What's the status of merging this one?  I'd like to merge the other
> patches.

i think it's necessary to rebase the whole series. Maybe we could get it
into 4.10.

Stefan
