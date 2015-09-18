From: rjui@broadcom.com (Ray Jui)
Date: Thu, 17 Sep 2015 18:20:36 -0700
Subject: [PATCH 1/4] ARM: dts: clean up Cygnus DT files
In-Reply-To: <55FB65E0.50407@gmail.com>
References: <1442534282-21356-1-git-send-email-rjui@broadcom.com>
 <1442534282-21356-2-git-send-email-rjui@broadcom.com>
 <55FB65E0.50407@gmail.com>
Message-ID: <55FB66E4.8010006@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/17/2015 6:16 PM, Florian Fainelli wrote:
> On 17/09/15 16:57, Ray Jui wrote:
>> This patch cleans up Cygnus DT files and makes the format consistent
>> with the rest of Broadcom iProc based SoCs.
>>
>> Changes include:
>>     - Put core components into "core" node of type "simple-bus"
>>     - Put all other peripherals into "soc" node of type "simple-bus"
>>     - Move aliases into bcm-cygnus.dtsi to avoid duplications in all dts
>>       files
>>     - Ordered all device nodes under buses based on their base register
>>       addresses
>>     - Remove unused PCI I/O resource
>>     - Use label instead of full path to reference device nodes in dts
>>       files
> 
> I am fine with the changes per-se, but the review is made largely more
> difficult because you mix multiple changes at the same time, this really
> ought to be separate patches to ease the review process. Sorry for not
> picking that up earlier.

Sure! I'll break them up into individual patches as follows:
- Put core components into "core" node of type "simple-bus"
- Put all other peripherals into "soc" node of type "simple-bus"
- Move aliases into bcm-cygnus.dtsi to avoid duplications in all dts files
- Ordered all device nodes under buses based on their base register
addresses
- Remove unused PCI I/O resources
- Use label instead of full path to reference device nodes in dts files

Thanks!

Ray
