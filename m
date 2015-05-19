From: wenyou.yang@atmel.com (Yang, Wenyou)
Date: Tue, 19 May 2015 11:07:29 +0800
Subject: at91sam9: watchdog: period
In-Reply-To: <5559A029.9060007@aksignal.cz>
References: <55559D55.6020703@aksignal.cz>	<20150515172516.005e3a21@bbrezillon>	<5559865F.9010502@aksignal.cz>
 <20150518092750.449d6c8c@bbrezillon> <5559A029.9060007@aksignal.cz>
Message-ID: <555AA8F1.80100@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/5/18 16:17, Ji?? Prchal wrote:
>
>
> On 18.5.2015 09:27, Boris Brezillon wrote:
>>
>> Can you dump watchdog registers (using devmem) ?
>
> / # devmem 0xfffffe40
> 0x00000000
> / # devmem 0xfffffe44
> 0x1FFF2FFF
> / # devmem 0xfffffe48
> 0x00000000
>
The register value is right.

I tested the Linux-3.18-at91-linux4sam_4.7 on the at91sam9g35ek. It 
reset the system in the 16s after removing atmel,idle-halt property.

Best Regards,
Wenyou Yang
