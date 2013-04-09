From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 9 Apr 2013 17:05:25 +0530
Subject: [PATCH v3 3/3] ARM: davinci: da850: add EHRPWM & ECAP DT node
In-Reply-To: <518397C60809E147AF5323E0420B992E3EAA9DA3@DBDE01.ent.ti.com>
References: <1364197789-16783-1-git-send-email-avinashphilip@ti.com>
 <1364197789-16783-4-git-send-email-avinashphilip@ti.com>
 <515A97DE.1080403@ti.com>
 <518397C60809E147AF5323E0420B992E3EAA91B6@DBDE01.ent.ti.com>
 <5162C1A5.5060808@ti.com>
 <518397C60809E147AF5323E0420B992E3EAA9DA3@DBDE01.ent.ti.com>
Message-ID: <5163FCFD.6070606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/9/2013 2:12 PM, Philip, Avinash wrote:
> On Mon, Apr 08, 2013 at 18:39:57, Nori, Sekhar wrote:
>>
>> On 4/8/2013 2:39 PM, Philip, Avinash wrote:
>>> On Tue, Apr 02, 2013 at 14:03:34, Nori, Sekhar wrote:
>>>> On 3/25/2013 1:19 PM, Philip Avinash wrote:
>>>>> Add da850 EHRPWM & ECAP DT node.
>>>>> Also adds OF_DEV_AUXDATA for EHRPWM & ECAP driver to use EHRPWM & ECAP
>>>>> clock.
>>>>
>>>> This looks fine to me but I will wait for the bindings to get accepted
>>>> before taking this one.
>>>
>>> Sekhar,
>>>
>>> Binding document got accepted in PWM tree [1].
>>> Can you accept this patch?
>>
>> Can you also add the pinmux definitions and resend just this patch?
>> Sorry I did not notice those were missing earlier.
> 
> According to latest schematics, ECAP instance 2 being used for PWM backlight
> control. Should I add pin-mux only for ECAP2 or for all PWM instances?

I meant add definitions in .dtsi. Since there is only one pin a given
functionality can be present on in DaVinci, it can be done in a board
independent manner. See examples for other peripherals in existing
da850.dtsi file.

Thanks,
Sekhar
