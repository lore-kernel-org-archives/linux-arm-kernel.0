From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 06 Aug 2015 19:15:59 +0200
Subject: [PATCH v3] ARM: dts: Convert Linkstation Mini to Device Tree
In-Reply-To: <1438880937.15635.92.camel@dolka.fr>
References: <1438878592.15635.89.camel@dolka.fr>	
 <20150806163424.GH13421@lunn.ch> <1438879473.15635.91.camel@dolka.fr>	
 <55C3929F.3030209@free-electrons.com> <1438880937.15635.92.camel@dolka.fr>
Message-ID: <55C3964F.5010708@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin,

On 06/08/2015 19:08, Benjamin Cama wrote:
> Hi Gr?gory,
> 
> Le jeudi 06 ao?t 2015 ? 19:00 +0200, Gregory CLEMENT a ?crit :
>> On 06/08/2015 18:44, Benjamin Cama wrote:
>>> Hi Andrew,
>>>
>>> Le jeudi 06 ao?t 2015 ? 18:34 +0200, Andrew Lunn a ?crit :
>>>> On Thu, Aug 06, 2015 at 06:29:52PM +0200, Benjamin Cama wrote:
>>>>> The title says it all. The name of the dts file as been changed 
>>>>> to
>>>>> better reflect the manufacturer's device name (LS-WSGL), rather 
>>>>>
>>>>> than
>>>>> the original "lsmini", which exists in a kirkwood version too.
>>>>>
>>>>> Signed-off-by: Benjamin Cama <benoar@dolka.fr>
>>>>
>>>> Hi Benjamin
>>>>
>>>> It would be normal to add the various Acked-by: here, both Alexey 
>>>> and
>>>> mine. It is not an issue, Gregory can add them, when he adds is 
>>>> own.
>>>> I'm just mentioning it for any future patches you might submit.
>>>
>>> Ah, OK, I was not sure and didn't want to add them by mistake.
>>
>> applied on mvebu/dt with the Acked-by: flags but also with some minor
>> fixes :I used tab instead of space to indent dts at line 185
> 
> Sorry, missed that.

No problem it was very minor, actually I didn't find myself, checpatch did
it for me :)

> 
>> and I
>> also resolved the merge conflict with patch "ARM: dts: orion5x: add
>> buffalo linkstation ls-wtgl" in the file arch/arm/boot/dts/Makefile.
> 
> Thanks, I didn't rebase on master for some time?

For this one you could not have do better, because the conflict
comes from a commit in my mvebu/dt branch and when you send a patch
we expect that it is based on the rc1. So it was really my job to
do this.

> 
> Thanks again for your time,

You're welcome and thanks for your contributions,

Gregory
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
