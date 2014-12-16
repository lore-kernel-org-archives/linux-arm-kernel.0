From: uwe@kleine-koenig.org (=?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=)
Date: Tue, 16 Dec 2014 22:47:31 +0100
Subject: [PATCHv1 1/3] rtc: rtc-isl12057: add alarm support to Intersil
 ISL12057 RTC driver
In-Reply-To: <87vblbdcii.fsf@natisbad.org>
References: <cover.1418687005.git.arno@natisbad.org>	<db1f0eecbdc5062a61232b99699ecfa6e0a2a956.1418687005.git.arno@natisbad.org>	<549004B9.2060402@kleine-koenig.org>
 <87vblbdcii.fsf@natisbad.org>
Message-ID: <5490A873.1000706@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnaud,

On 12/16/2014 01:07 PM, Arnaud Ebalard wrote:
>>> FWIW, if someone is looking for a way to test alarm support this can
>>> be done in the following way:
>>>
>>>     # echo `date '+%s' -d '+ 1 minutes'` > /sys/class/rtc/rtc0/wakealarm
>>>     # shutdown -h now
>>>
>>> With the commands above, after a minute, the system comes back to life.
>> This paragraph belongs into the 2nd patch, right?
> 
> no, it is for this patch. I did a specific commit message for the second
> patch. IIRC, it also has the example if it was the meaning of your
> question.
Is it usual that an rtc can wake up a machine from shutdown state? I
thought it isn't.

Best regards
Uwe
