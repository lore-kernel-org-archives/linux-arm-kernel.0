From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 31 Jul 2014 16:21:40 +0200
Subject: [PATCH] ARM: mvebu: Add RTC support for Armada 375
In-Reply-To: <20140731161529.09c55afb@free-electrons.com>
References: <1406814276-11361-1-git-send-email-gregory.clement@free-electrons.com>
 <20140731161529.09c55afb@free-electrons.com>
Message-ID: <53DA50F4.3030204@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 31/07/2014 16:15, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Thu, 31 Jul 2014 15:44:36 +0200, Gregory CLEMENT wrote:
> 
>> The Armada 375 XP Socs have the same controller that the one used in
>> the orion platforms. This patch updates the device tree for these
>> SoCs.
> 
> Actually there's only one Armada 375 SoC, so singular would be good.

On this point I was referring to the chips not to the family. But I agree
that it can be understood in both way.

> And s/that/than/ as well. And "controller" is a bit vague. Proposal:
> 
> """
> The Armada 375 SoC has the same real time clock as the one used in
> other Marvell EBU platforms. This patch consequently updates the Device
> Tree of the Armada 375 SoC to describe the internal RTC.
> """

I agree with your proposal I will sent a new version soon.

Thanks,

Gregory


> 
> Thanks,
> 
> Thomas
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
