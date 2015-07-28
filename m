From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 28 Jul 2015 11:38:26 +0200
Subject: [PATCH 1/3] ARM: at91/soc: add basic support for new sama5d2 SoC
In-Reply-To: <55B7435A.2060205@atmel.com>
References: <cover.1434632966.git.nicolas.ferre@atmel.com>
 <fe6d862c640a3708e80c0cc4c694ab5d9079060b.1434632966.git.nicolas.ferre@atmel.com>
 <20150618152105.GK27492@piout.net> <55913E3B.6060009@atmel.com>
 <20150629150421.GB485@piout.net> <55B7435A.2060205@atmel.com>
Message-ID: <55B74D92.7080702@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 28/07/2015 10:54, Nicolas Ferre a ?crit :
> Le 29/06/2015 17:04, Alexandre Belloni a ?crit :
>> On 29/06/2015 at 14:46:51 +0200, Nicolas Ferre wrote :
>>> Le 18/06/2015 17:21, Alexandre Belloni a ?crit :
>>>> Hi,
>>>>
>>>> On 18/06/2015 at 15:18:28 +0200, Nicolas Ferre wrote :
>>>>> diff --git a/Documentation/arm/Atmel/README b/Documentation/arm/Atmel/README
>>>>> index c53a19b4aab2..6650a8ffaa64 100644
>>>>> --- a/Documentation/arm/Atmel/README
>>>>> +++ b/Documentation/arm/Atmel/README
>>>>> @@ -90,6 +90,12 @@ the Atmel website: http://www.atmel.com.
>>>>>          + Datasheet
>>>>>            http://www.atmel.com/Images/Atmel-11238-32-bit-Cortex-A5-Microcontroller-SAMA5D4_Datasheet.pdf
>>>>>  
>>>>> +    * ARM Cortex-A5 + NEON based SoCs
>>>>> +      - sama5d2 family
>>>>> +        - sama5d27
>>>>> +        + Datasheet
>>>>> +          Coming soon
>>>>
>>>> Shouldn't that go directly before or after the sama5d4 family ?
>>>
>>> This is "after" sama5d4: I sorted this file according to SoC release
>>> date whereas I sorted the other entries in alpa-numerial order (sama5d2
>>> placed before sama5d3).
>>>
>>> Is it what you answered?
>>>
>>
>> No, I meant doing something like:
>>
>>     * ARM Cortex-A5 + NEON based SoCs
>>       - sama5d4 family
>>         - sama5d41
>>         - sama5d42
>>         - sama5d43
>>         - sama5d44 (device superset)
>>         + Datasheet
>>           http://www.atmel.com/Images/Atmel-11238-32-bit-Cortex-A5-Microcontroller-SAMA5D4_Datasheet.pdf
>>       - sama5d2 family
>>         - sama5d27
>>         + Datasheet
>>           Coming soon
>>
>> Else, you end up with two "ARM Cortex-A5 + NEON based SoCs" sections.
> 
> Oh, yes. Sure, I'll modify this.
> 
> Do you think that it's worth sending another series or I can take it for
> the pull-request when it's modified?

Actually, I realized that I have some more nodes to add to the DT
descriptions, to it's worth sending a v2 of this series...

Bye,
-- 
Nicolas Ferre
