From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 06 Aug 2015 19:00:15 +0200
Subject: [PATCH v3] ARM: dts: Convert Linkstation Mini to Device Tree
In-Reply-To: <1438879473.15635.91.camel@dolka.fr>
References: <1438878592.15635.89.camel@dolka.fr>
 <20150806163424.GH13421@lunn.ch> <1438879473.15635.91.camel@dolka.fr>
Message-ID: <55C3929F.3030209@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin,

On 06/08/2015 18:44, Benjamin Cama wrote:
> Hi Andrew,
> 
> Le jeudi 06 ao?t 2015 ? 18:34 +0200, Andrew Lunn a ?crit :
>> On Thu, Aug 06, 2015 at 06:29:52PM +0200, Benjamin Cama wrote:
>>> The title says it all. The name of the dts file as been changed to
>>> better reflect the manufacturer's device name (LS-WSGL), rather 
>>> than
>>> the original "lsmini", which exists in a kirkwood version too.
>>>
>>> Signed-off-by: Benjamin Cama <benoar@dolka.fr>
>>
>> Hi Benjamin
>>
>> It would be normal to add the various Acked-by: here, both Alexey and
>> mine. It is not an issue, Gregory can add them, when he adds is own.
>> I'm just mentioning it for any future patches you might submit.
> 
> Ah, OK, I was not sure and didn't want to add them by mistake.

applied on mvebu/dt with the Acked-by: flags but also with some minor
fixes :I used tab instead of space to indent dts at line 185 and I
also resolved the merge conflict with patch "ARM: dts: orion5x: add
buffalo linkstation ls-wtgl" in the file arch/arm/boot/dts/Makefile.

Thanks,

Gregory


> 
>> Thanks for the good work converting this,
> 
> Thanks!
> --
> benjamin
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
