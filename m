From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 10 Jul 2012 14:13:17 +0530
Subject: [PATCH] ARM: davinci: cp_intc: Add OF support for TI interrupt
 controller
In-Reply-To: <4FF71822.2070908@ti.com>
References: <1341342970-27535-1-git-send-email-nsekhar@ti.com>
 <4FF58BDC.6060802@denx.de> <4FF71822.2070908@ti.com>
Message-ID: <4FFBEB25.6040501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 7/6/2012 10:23 PM, Sekhar Nori wrote:
> Hi Grant,
> 
> On 7/5/2012 6:13 PM, Heiko Schocher wrote:
>> Hello Sekhar,
>>
>> On 03.07.2012 21:16, Sekhar Nori wrote:
>>> From: Heiko Schocher<hs@denx.de>
>>>
>>> Add a function to initialize the Common Platform Interrupt Controller
>>> (cp_intc) from TI used on OMAP-L1x SoCs using a device tree node.
>>>
>>> Signed-off-by: Heiko Schocher<hs@denx.de>
>>> Cc: davinci-linux-open-source at linux.davincidsp.com
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: devicetree-discuss at lists.ozlabs.org
>>> Cc: Grant Likely<grant.likely@secretlab.ca>
>>> Cc: Sekhar Nori<nsekhar@ti.com>
>>> Cc: Wolfgang Denk<wd@denx.de>
>>> Cc: Sergei Shtylyov<sshtylyov@mvista.com>
>>> Signed-off-by: Sekhar Nori<nsekhar@ti.com>
>>> ---
>>>   .../devicetree/bindings/arm/davinci/cp-intc.txt    |   27
>>> ++++++++++++++++++++
>>>   arch/arm/mach-davinci/cp_intc.c                    |   16 +++++++++---
>>>   arch/arm/mach-davinci/include/mach/cp_intc.h       |    1 +
>>>   3 files changed, 41 insertions(+), 3 deletions(-)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/arm/davinci/cp-intc.txt
>>
>> Thanks!
>>
>> Tested on the enbw_cmc board.
> 
> Any further feedback on this? If you are OK, I would like to queue this
> for v3.6 through DaVinci tree.

Do you have any feedback on this patch? Looks like Grant is going to be
busy for a while. If you do not have the original patch I can forward it
to you.

Thanks,
Sekhar
