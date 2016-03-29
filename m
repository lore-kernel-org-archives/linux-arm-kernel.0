From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 29 Mar 2016 15:53:35 +0200
Subject: [PATCH 1/3] ARM: at91: use chipid device for soc detection
In-Reply-To: <20160323134750.GC2570@piout.net>
References: <1458285681-25684-1-git-send-email-ludovic.desroches@atmel.com>
 <20160318103418.GA2531@piout.net> <56F27C89.9070004@atmel.com>
 <20160323134750.GC2570@piout.net>
Message-ID: <56FA88DF.20208@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 23/03/2016 14:47, Alexandre Belloni a ?crit :
> On 23/03/2016 at 12:22:49 +0100, Nicolas Ferre wrote :
>> Le 18/03/2016 11:34, Alexandre Belloni a ?crit :
>>> On 18/03/2016 at 08:21:19 +0100, Ludovic Desroches wrote :
>>>> So far, the CIDR and EXID registers were in the DBGU interface. This device
>>>> has disappeared with the SAMA5D2 family. These registers are exposed
>>>> through a new device called chipid.
>>>>
>>>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>>>> [nicolas.ferre at atmel.com: remove useless warnings]
>>> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>>
>>>> ---
>>>>  .../devicetree/bindings/arm/atmel-at91.txt         |  4 ++
>>>>  arch/arm/mach-at91/soc.c                           | 81 +++++++++++++++++-----
>>
>> We may need to split this patch in 2 for going through separate arm-soc
>> branches: what do you think Alexandre?
>>
> 
> I think the patch can go in as it is now, the documentation being in
> line with the code.

Okay: patches 1 & 2 in the "soc" branch.
patch 3 in the "dt" branch.

Bye,
-- 
Nicolas Ferre
