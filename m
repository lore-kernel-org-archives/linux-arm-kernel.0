From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Sun, 10 Jan 2016 13:13:24 +0000
Subject: [PATCH] ARM: dts: imx28: add pinmux for USB1 overcurrent on pwm2
In-Reply-To: <1473600647.505612.cb24b396-67be-4b7b-9938-7cb30ef4fe05.open-xchange@email.1und1.de>
 (Stefan Wahren's message of "Sun, 10 Jan 2016 14:08:40 +0100 (CET)")
References: <1452429613-28783-1-git-send-email-mans@mansr.com>
 <1473600647.505612.cb24b396-67be-4b7b-9938-7cb30ef4fe05.open-xchange@email.1und1.de>
Message-ID: <yw1xoacty3uz.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Mans,
>
>> Mans Rullgard <mans@mansr.com> hat am 10. Januar 2016 um 13:40 geschrieben:
>>
>>
>> Add pinmux setting for USB1 overcurrent on pwm2 pad.
>
> could you please change your patch to describe why you need to add
> this pinmux?

I'm working on a board that is wired that way.  I can of course put this
in the board-specific dts if that's preferable.

-- 
M?ns Rullg?rd
