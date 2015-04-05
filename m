From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Sun, 5 Apr 2015 21:50:16 +0200
Subject: Two new breakages since Thursday
In-Reply-To: <20150405101219.GS20669@piout.net>
References: <20150405080645.GE13898@n2100.arm.linux.org.uk>
 <20150405101219.GS20669@piout.net>
Message-ID: <552191F8.3010007@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 05/04/2015 12:12, Alexandre Belloni a ?crit :
> Hi,
> 
> On 05/04/2015 at 09:06:45 +0100, Russell King - ARM Linux wrote :
>> So, if we build a kernel with ARMc6 and ARMv7 CPUs, AT91 ends up using
>> ARMv7-only instructions in this function, which will cause an illegal
>> instruction exception on ARMv6 CPUs.
>>
> 
> A fix has been pushed to the at91 tree but has not been pulled in
> arm-soc yet.

Yes, I'll try to re-spin my pull requests soon so that it can be merged
quickly.

Thanks for the "heads up". Bye,
-- 
Nicolas Ferre
