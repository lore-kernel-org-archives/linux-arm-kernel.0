From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 12 Jan 2015 09:55:03 +0100
Subject: [PATCH] avr32: remove fake at91 cpu identification
In-Reply-To: <20150111121012.GB4050@samfundet.no>
References: <1420941616-2777-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150111121012.GB4050@samfundet.no>
Message-ID: <54B38BE7.1070203@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 11/01/2015 13:10, Hans-Christian Egtvedt a ?crit :
> Around Sun 11 Jan 2015 03:00:16 +0100 or thereabout, Alexandre Belloni wrote:
>> cpu_is_at91* are not used in any driver outside mach-at91. Remove those useless
>> definitions.
> 
> Great, thank you for cleaning.
> 
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>
> 
> Acked-by: Hans-Chrisitan Egtvedt <egtvedt@samfundet.no>
> 
>> ---
>>
>> Hans-Christian,
>>
>> If you want, I guess that one could go through the at91 tree. Unless you have
>> more material and you want to do a pull request for 3.20.
> 
> I have another patch in the pipe wiring up syscalls for AVR32, so I'll push
> this through my tree for 3.20.

Okay, so you can add my:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Bye,

>>  arch/avr32/mach-at32ap/include/mach/cpu.h | 26 +-------------------------
>>  1 file changed, 1 insertion(+), 25 deletions(-)
> 
> <snipp diff>
> 


-- 
Nicolas Ferre
