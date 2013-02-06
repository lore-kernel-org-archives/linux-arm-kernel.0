From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 6 Feb 2013 14:30:36 +0100
Subject: [PATCH 0/2] ARM: dts: omap3-overo: Add pwm-leds and audio support
In-Reply-To: <510F7BEB.1020408@epfl.ch>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
 <5101273A.9090800@ti.com> <510F7BEB.1020408@epfl.ch>
Message-ID: <51125AFC.10704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Salut Florian,

On 02/04/2013 10:14 AM, Florian Vaussard wrote:
> Hello Benoit,
> 
> On 01/24/2013 01:21 PM, Benoit Cousson wrote:
>> + Peter who did the original PWM
>>
>> Hi Florian,
>>
>> On 01/23/2013 06:56 PM, Florian Vaussard wrote:
>>> Hello Benoit,
>>>
>>> This patchset adds some new DT supports to the Overo products. The
>>> first patch converts the PMIC LEDB output to use the pwm-leds,
>>> newly merged in your branch for_3.9/dts. The second patch adds the
>>> audio support.
>>
>> Excellent, that looks very good to me, but I'd like to get the
>> feedback from Peter before merging it.
>>
> 
> So a patch is being merged to handle triggers in the case of pwm leds [1].
> When done, we will be able to add back the default trigger. Do you want
> to wait on it to merge this series?

What kind of dependency do we have between these two series? I mean what
will happen if the DTS is merged before the pwm subsystem?

If that does not generate any regression / crash, then it is OK, if not,
we should take care of the order.

Thanks,
Benoit
