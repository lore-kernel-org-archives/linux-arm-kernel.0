From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 8 Sep 2016 21:19:36 +0300
Subject: [PATCH V3 0/5] firmware: Add support for TI System Control
 Interface (TI-SCI) protocol driver
In-Reply-To: <m2y432nvs8.fsf@baylibre.com>
References: <20160906190127.23522-1-nm@ti.com> <7hshtbtu8l.fsf@baylibre.com>
 <f41d968c-46c9-997e-0fa0-edbef34a1fa5@ti.com> <m2y432nvs8.fsf@baylibre.com>
Message-ID: <9c609ea5-5ea8-f58a-ae32-f8af2c85dd72@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/16 20:31, Kevin Hilman wrote:
> Nishanth Menon <nm@ti.com> writes:
>
>> On 09/07/2016 01:55 PM, Kevin Hilman wrote:
>>> Nishanth Menon <nm@ti.com> writes:
>>
>> [...] full mail thread in https://lkml.org/lkml/2016/9/6/747
>>
>>>> Overall architecture is very similar to SCPI[4] as follows:
>>>
>>> Dumb Q: I'm curious about the limitations in SCPI that were found that
>>> made TI decided to implement its own version.
>
> [...]
>
>> Long story short, investigation was done into what SCPI was providing
>> (TI internal ofcourse) and SCPI did not fit our SoC generation needs -
>
> Thanks for the detailed explanation.  Very helpful.
>
> To be clear, I'm not a proponent of always using ARM "standards"
> (especially when it's not exactly clear if it's a standard or a Juno
> thing) but I'm seeing several SoCs come out with SCPI derivatives, or
> old ARM versions etc., so was just curious about the decision making
> process.
>
> Thanks for sharing,
>
> Kevin

So, any other comments for this series or shall we still try to get it 
merged for 4.9? We are -rc5 so it might be too late already and probably 
better to push this for 4.10.

-Tero
