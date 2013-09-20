From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 20 Sep 2013 09:37:25 +0200
Subject: [PATCH] phy/micrel: Add suspend/resume support to Micrel PHYs
In-Reply-To: <20130919.140829.372011462903870193.davem@davemloft.net>
References: <1379612448-20805-1-git-send-email-nicolas.ferre@atmel.com>
 <20130919.140829.372011462903870193.davem@davemloft.net>
Message-ID: <523BFB35.6030509@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/09/2013 20:08, David Miller :
> From: Nicolas Ferre <nicolas.ferre@atmel.com>
> Date: Thu, 19 Sep 2013 19:40:48 +0200
>
>> From: Patrice Vilchez <patrice.vilchez@atmel.com>
>>
>> All supported Micrel PHYs implement the standard "power down" bit 11 of BMCR,
>> so this patch adds support using the generic genphy_{suspend,resume} functions.
>>
>> Signed-off-by: Patrice Vilchez <patrice.vilchez@atmel.com>
>> [b.brezillon at overkiz.com: adapt to newer kernel and generalize to other phys]
>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>> [nicolas.ferre at atmel.com: commit message modification]
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Cc: David J. Choi <david.choi@micrel.com>
>
> What's the difference between this patch and the one you sent 60
> seconds beforehand?

No difference, just the addition of Boris in the CC list.
He was missing in the previous one despite his presence in the 
"Signed-off-by" tag. I tried to stop "git send-email" before it can 
complete but I hit "Ctrl-c" too late it seems...

Sorry for the noise.

Bye,
-- 
Nicolas Ferre
