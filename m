From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 19 Sep 2017 07:08:05 +0200
Subject: [PATCH 0/4] arm64: Add initial Actions Semi S700 and CubieBoard7
 support
In-Reply-To: <6beabaab-d95f-4ac9-96f1-7c1c98bd7811@linaro.org>
References: <20170911022241.11603-1-afaerber@suse.de>
 <6beabaab-d95f-4ac9-96f1-7c1c98bd7811@linaro.org>
Message-ID: <0a3e9a40-cb67-d2b2-7f06-fa0f24a4fb42@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Am 18.09.2017 um 23:50 schrieb Daniel Lezcano:
> On 11/09/2017 04:22, Andreas F?rber wrote:
>> Cc: devicetree at vger.kernel.org
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>
>> Andreas F?rber (4):
>>   dt-bindings: arm: actions: Add S700 and CubieBoard7
>>   dt-bindings: timer: Add Actions Semi S700
>>   clocksource: owl: Prepare S700
>>   arm64: dts: actions: Add S700 and CubieBoard7
>>
>>  Documentation/devicetree/bindings/arm/actions.txt  |  15 ++
>>  .../bindings/timer/actions,owl-timer.txt           |   1 +
> 
> Usually sub system maintainers are also Cc'ed with Dt bindings
> definitions and usage.

Your MAINTAINERS entry is lacking an entry for the bindings. Can you
please fix that in linux-next? Then the next patches should reach you.

Actually I'm even surprised that it works for the drivers - I would
expect a trailing "/" for the directory (see line 95ff).

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
