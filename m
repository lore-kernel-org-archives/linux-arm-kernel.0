From: rickard.andersson@stericsson.com (Rickard Andersson)
Date: Fri, 1 Mar 2013 14:28:18 +0100
Subject: [PATCH 3/4] ARM: nomadik: add dynamic irq flag to the timer
In-Reply-To: <CAKfTPtA=7pTPrwFHr61WiffXGv2Ztmaiji5q_vJpPj9XgyeZMg@mail.gmail.com>
References: <1361917047-29230-1-git-send-email-daniel.lezcano@linaro.org>	<1361917047-29230-4-git-send-email-daniel.lezcano@linaro.org>	<CACRpkda=i5cXSbYCyb0gH0OLKj7396qguup1nqgqn0m-S1x1wg@mail.gmail.com>
 <CAKfTPtA=7pTPrwFHr61WiffXGv2Ztmaiji5q_vJpPj9XgyeZMg@mail.gmail.com>
Message-ID: <5130ACF2.6070005@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2013 09:56 AM, Vincent Guittot wrote:
> On 1 March 2013 02:13, Linus Walleij<linus.walleij@linaro.org>  wrote:
>> On Tue, Feb 26, 2013 at 11:17 PM, Daniel Lezcano
>> <daniel.lezcano@linaro.org>  wrote:
>>
>>> Add the dynamic irq affinity feature to the timer clock device.
>>>
>>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>> Looks reasonable to me, sadly I do not fully grasp the patch set,
>> Vincent+Rickard can you have a look at this?
> ux500 is able to trig the wake up on one CPU and let the other one in
> WFI. This patch will minimize the spurious wake up of CPU0 when CPU1
> is the target CPU of the broadcast timer. One main consequence is that
> we will not uselessly execute all the deferrable and newly idle
> activities on the CPU0 .
>
> you can add my reviewed-by if you want
>
> Vincent
>
It looks ok to me as well.

BR
Rickard
