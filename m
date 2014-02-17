From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 17 Feb 2014 12:08:38 +0100
Subject: [PATCH 1/3] ARM: at91: Add at91sam9rl DT SoC support
In-Reply-To: <20140217105439.GC21303@piout.net>
References: <1392426860-19589-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1392426860-19589-2-git-send-email-alexandre.belloni@free-electrons.com>
 <20140217112013.723a4e12@skate> <20140217105439.GC21303@piout.net>
Message-ID: <5301EDB6.9020102@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/02/2014 11:54, Alexandre Belloni :
> On 17/02/2014 at 11:20:13 +0100, Thomas Petazzoni wrote :
>> Dear Alexandre Belloni,
>>
>> On Sat, 15 Feb 2014 02:14:18 +0100, Alexandre Belloni wrote:
>>
>>> +	model = "Atmel AT91SAM9RL family SoC";
>>> +	compatible = "atmel,at91sam9rl";
>>
>> Since you have it in your board .dts file, I guess you should add the
>> atmel,at91sam9 compatible string here:
>>
>> 	compatible = "atmel,at91sam9rl", "atmel,at91sam9";
> 
> 
> I agree that it would be better but that is not done on other at91sam9
> socs. Nicolas, can you comment ?

I do agree with Thomas. It is true that it is missing in other sam9 dtsi
files.
On the other hand, it is present in sama5d3.dtsi file. So we might have
figured it out at some point ;-)

Bye,
-- 
Nicolas Ferre
