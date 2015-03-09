From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 09 Mar 2015 17:19:28 +0000
Subject: [PATCH 1/2] arm64: juno: Add APB registers and LEDs using syscon
In-Reply-To: <1425917877.2657.12.camel@linaro.org>
References: <1424866589-2988-1-git-send-email-linus.walleij@linaro.org>	
 <20150225135512.GE12377@arm.com>	
 <20150225144756.GA905@e106497-lin.cambridge.arm.com>	
 <20150225150023.GJ12377@arm.com>	
 <20150225151157.GC905@e106497-lin.cambridge.arm.com>	
 <CACRpkdYd7ZOMt1QxhCxzhavhcd8wcWrC2j1Ce5eGP9piX=xwkQ@mail.gmail.com>	
 <20150227140600.GZ905@e106497-lin.cambridge.arm.com>	
 <54FD767F.5010507@arm.com> <1425917877.2657.12.camel@linaro.org>
Message-ID: <54FDD620.1010703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/03/15 16:17, Jon Medhurst (Tixy) wrote:
> On Mon, 2015-03-09 at 10:31 +0000, Sudeep Holla wrote:
>>
>> On 27/02/15 14:06, Liviu Dudau wrote:
>>> On Fri, Feb 27, 2015 at 01:07:42PM +0000, Linus Walleij wrote:
>>>> On Wed, Feb 25, 2015 at 4:11 PM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>>
>> [...]
>>
>>> I'm mostly on your side, Linus, I was just looking for more use cases. Like I've said,
>>> most of our customers seem to keep the case closed (or at least that is what they tell
>>> us :) ) so I'm looking for explanations on how you use the LEDs (visual debugging for
>>> big-LITTLE was how Lorenzo was using them on TC2 for example).
>>>
>>
>> Just to clarify:
>>
>> IIUC all VExpress platforms has these LEDs on the motherboard. The one
>> you are referring is on the TC2 core-tile which are completely
>> controlled by the firmware. The main advantage of that was to know if
>> the OSPM request is accepted by the firmware.
>>
>> But the LEDs being referred here are under OS control and gives only the
>> OS view of the state which is good enough but not exactly what we had on
>> TC2.
>
> Well, when a TC2 CoreTile is plugged into the Versatile Express
> motherboard you get those LEDs as well and can see what the OS thinks is
> the state of the CPU's. I've found this useful in the past for debugging
> problems caused by a mismatch between the OS's and firmware's view of
> the world.
>

I agree, I just wanted to clarify that the LEDs that were more useful
while debugging PM on TC2 were those on the coretile rather than the one
on the motherboard and that there are managed by firmware.

Regards,
Sudeep
