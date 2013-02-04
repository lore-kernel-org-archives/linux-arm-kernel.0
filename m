From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 04 Feb 2013 10:14:19 +0100
Subject: [PATCH 0/2] ARM: dts: omap3-overo: Add pwm-leds and audio support
In-Reply-To: <5101273A.9090800@ti.com>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
 <5101273A.9090800@ti.com>
Message-ID: <510F7BEB.1020408@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Benoit,

On 01/24/2013 01:21 PM, Benoit Cousson wrote:
> + Peter who did the original PWM
>
> Hi Florian,
>
> On 01/23/2013 06:56 PM, Florian Vaussard wrote:
>> Hello Benoit,
>>
>> This patchset adds some new DT supports to the Overo products. The
>> first patch converts the PMIC LEDB output to use the pwm-leds,
>> newly merged in your branch for_3.9/dts. The second patch adds the
>> audio support.
>
> Excellent, that looks very good to me, but I'd like to get the
> feedback from Peter before merging it.
>

So a patch is being merged to handle triggers in the case of pwm leds [1].
When done, we will be able to add back the default trigger. Do you want
to wait on it to merge this series?

Regards,

Florian

[1] https://patchwork.kernel.org/patch/2056191/
