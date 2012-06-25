From: javier.martin@vista-silicon.com (javier Martin)
Date: Mon, 25 Jun 2012 09:04:26 +0200
Subject: imx27_visstrim_m10: spot the mistake
In-Reply-To: <20120625064903.GA14321@pengutronix.de>
References: <20120624165710.GA20378@n2100.arm.linux.org.uk>
 <20120625064903.GA14321@pengutronix.de>
Message-ID: <CACKLOr0SZAerw1adE9xZ+PuwtGWVuo8M=yCqKAog2SAmiyK9mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 June 2012 08:49, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Sun, Jun 24, 2012 at 05:57:10PM +0100, Russell King - ARM Linux wrote:
>> commit 9f97da78bf018206fb623cd351d454af2f105fe0
>> Author: David Howells <dhowells@redhat.com>
>> Date: ? Wed Mar 28 18:30:01 2012 +0100
>>
>> ? ? Disintegrate asm/system.h for ARM
>>
>> ? ? Disintegrate asm/system.h for ARM.
>>
>> ? ? Signed-off-by: David Howells <dhowells@redhat.com>
>> ? ? cc: Russell King <linux@arm.linux.org.uk>
>> ? ? cc: linux-arm-kernel at lists.infradead.org
>>
>> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
>> index 774c41e..74542c5 100644
>> --- a/arch/arm/include/asm/system.h
>> +++ b/arch/arm/include/asm/system.h
>> +/* FILE TO BE DELETED. DO NOT ADD STUFF HERE! */
>> +#include <asm/barrier.h>
>> +#include <asm/compiler.h>
>> +#include <asm/cmpxchg.h>
>> +#include <asm/exec.h>
>> +#include <asm/switch_to.h>
>> +#include <asm/system_info.h>
>> +#include <asm/system_misc.h>
>>
>> What's wrong with the above commit to mach-imx27_visstrim_m10.c ?
>
> Sorry Russell, thank you Fabio for sending a patch.
>

Sorry, thank you for spotting the mistake.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
