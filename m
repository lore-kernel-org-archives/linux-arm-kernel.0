From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 21 Jul 2015 18:46:11 +0200
Subject: [PATCH v3 0/2] RTC support for NXP LPC18xx family
In-Reply-To: <20150721162850.GE2853@piout.net>
References: <1436635730-15617-1-git-send-email-manabian@gmail.com>
 <20150721162850.GE2853@piout.net>
Message-ID: <CAGhQ9VwJvs8qwhDrUd8P0Fz3v-MtQOq+Nfd5YegZZEVbDYNgqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 July 2015 at 18:28, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi,
>
> On 11/07/2015 at 19:28:48 +0200, Joachim Eastwood wrote :
>> This patch set adds support for the RTC found on many NXP devices
>> including LPC178x/18xx/408x/43xx. The RTC provides calendar and
>> clock functionality together with alarm interrupt support.
>>
>> The driver is a rework of an old driver by Kevin Wells. It has been
>> modified to support modern resource allocation, device tree and
>> generally cleaned up. Driver was originally written to support the
>> LPC24xx platform but since this platform isn't upstream support has
>> been removed. The LPC24xx name is still kept to preserve the origin
>> of this hardware block.
>>
>> Been a while since the last version, but this version should address
>> all comments from Josh and Alexandre on v2. There has also been some
>> rework from my side. Please have a look.
>>
>> changes since v2:
>>  - rework hw init
>>  - update Kconfig text
>>  - remove unused registers defines
>>  - misc clean ups
>>  - rebase on 4.2-rc1
>>
>> changes since v1:
>>  - s/lpc2k/lpc24xx for better consistency
>>  - fix Kconfig entry
>>  - drop support for old versions for the ip block
>>
>> Patch set is based on Linux v4.2-rc1.
>>
>> Joachim Eastwood (2):
>>   rtc: add rtc-lpc24xx driver
>>   doc: dt: add documentation for nxp,lpc1788-rtc
>>
>
> Applied both after adding a proper commit log to the second patch,
> reordering to avoid a checkpatch warning and fixing the typo in kevin's
> mail address.

Thanks for fixing up and applying, Alexandre.

regards,
Joachim Eastwood
