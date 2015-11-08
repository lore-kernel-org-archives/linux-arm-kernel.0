From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun, 08 Nov 2015 17:39:51 +0200
Subject: [PATCH v2 0/8] arm: dts: lpc32xx: updates to LPC32xx SoC and
 boards
In-Reply-To: <3973745.SoYxz6UFdV@wuerfel>
References: <1445117757-8073-1-git-send-email-vz@mleia.com>
 <3973745.SoYxz6UFdV@wuerfel>
Message-ID: <563F6CC7.3050704@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 21.10.2015 17:45, Arnd Bergmann wrote:
> On Sunday 18 October 2015 00:35:49 Vladimir Zapolskiy wrote:
>> The change improves description of NXP LPC32xx hardware, among
>> important changes it adds standard timers and external memory
>> controller nodes, splits PWM device node into two,
>>
>> Changes from v1 to v2:
>> - removed v1 2/5 "arm: dts: lpc32xx: fix improper usage of ranges property"
>> - v1 4/5 "arm: dts: lpc32xx: remove unneeded cell settings from cpus"
>>   is replaced by v2 3/8 "arm: dts: lpc32xx: add reg property to cpu device node"
>> - new change, sets physical memory offset for EA3250 and PHY3250 v5/8
>> - new change, added EMC device node v2 6/8
>> - new change, added standard timer nodes v2 7/8
>> - new change, grouped USB subdevices together v2 8/8
> 
> Looks ok to me. Who should pick them up? I haven't seen pull requests from
> Roland in a while. If he's still interested in the port, I think it would be
> best if he could create a branch here.
> 
> If not, we can pick them up directly this time into arm-soc, but then we
> should find a new maintainer.
> 
> 	Arnd 

please pick this series up for v4.3, if it is still possible.

Thank you.

--
With best wishes,
Vladimir
