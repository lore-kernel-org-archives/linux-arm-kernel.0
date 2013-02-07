From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 7 Feb 2013 08:58:36 +0100
Subject: [PATCH 0/2] ARM: dts: omap3-overo: Add pwm-leds and audio support
In-Reply-To: <51125AFC.10704@ti.com>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
 <5101273A.9090800@ti.com> <510F7BEB.1020408@epfl.ch> <51125AFC.10704@ti.com>
Message-ID: <51135EAC.7010406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/06/2013 02:30 PM, Benoit Cousson wrote:
>> So a patch is being merged to handle triggers in the case of pwm leds [1].
>> When done, we will be able to add back the default trigger. Do you want
>> to wait on it to merge this series?
> 
> What kind of dependency do we have between these two series? I mean what
> will happen if the DTS is merged before the pwm subsystem?
> 
> If that does not generate any regression / crash, then it is OK, if not,
> we should take care of the order.

In this series the 'linux,default-trigger' property is not added to the
pwm-leds node, so it is safe to take this series.
I'm sure Florian will send the update to add this flag back for 3.10 or for
3.9-rc (the needed patches for PWM and leds-pwm will be in 3.9).

I'm also waiting for 3.9-rc1 so I can finish up some of the pending things
regarding to PWMs.

-- 
P?ter
