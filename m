From: uwe@kleine-koenig.org (=?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=)
Date: Tue, 02 Dec 2014 09:26:45 +0100
Subject: [PATCHv1 6/6] rtc: rtc-isl12057: add alarm support to Intersil
 ISL12057 RTC driver
In-Reply-To: <87tx1fnn9y.fsf@natisbad.org>
References: <cover.1416006090.git.arno@natisbad.org>
 <986ee8d9d3e6862007f398ffddc2a4bb2368933e.1416006090.git.arno@natisbad.org>
 <5476ED9F.2070600@kleine-koenig.org> <87tx1fnn9y.fsf@natisbad.org>
Message-ID: <547D77C5.2080705@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On December 1, 2014 9:11:21 PM CET, arno at natisbad.org wrote:
>Uwe Kleine-K?nig <uwe@kleine-koenig.org> writes:
>> For patch 1: Maybe point out that the issue with the century bit
>isn't
>> that critical, because this bit is not expected to be set before year
>> 2100.
>
>It has:
>
>   This was tested by putting a device 100 years in the future (using a
> specific kernel due to the inability of userland tools such as date or
>hwclock to pass year 2038), rebooting on a kernel w/ this patch applied
>    and verifying the device was still 100 years in the future.
>
That describes your test, but it doesn't rule out that someone might use
the century bit to distinguish 19** and 20**.

Best regards
Uwe
