From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 15 Aug 2013 14:00:42 -0500
Subject: [PATCH] drivers: CCI: add ARM CCI PMU support
In-Reply-To: <520C9AEA.6030507@arm.com>
References: <1374571176-11584-1-git-send-email-punit.agrawal@arm.com>
 <2CD735CE-3FCF-4AB5-89C0-D813ECD19F11@codeaurora.org>
 <520C9AEA.6030507@arm.com>
Message-ID: <9E753731-852D-4F04-931B-112B589D9FFB@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Aug 15, 2013, at 4:10 AM, Punit Agrawal wrote:

>> What is the list of interrupts related to, should there be an associated interrupts-names
>> 
> 
> For the CCI PMU, each interrupt signal corresponds to the overflow of a performance counter.
> 
> Here again, I was trying to be robust in the face of differing hardware configurations - specially the scenario where multiple interrupt lines from the CCI PMU are tied together to generate a single interrupt to the CPU.

Even in the case of multiple interrupt lines tied together, why wouldn't you still specify each interrupt specifier and they all just be the same and thus the interrupt appears to be shared ?

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
