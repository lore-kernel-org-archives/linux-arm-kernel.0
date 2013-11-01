From: dmitry_eremin@mentor.com (Dmitry Eremin-Solenikov)
Date: Fri, 1 Nov 2013 23:54:53 +0400
Subject: [PATCH 4/4] ARM: sa1100: switch to COMMON_CLK framework
In-Reply-To: <20131101105933.GL16735@n2100.arm.linux.org.uk>
References: <1383303131-29550-1-git-send-email-dmitry_eremin@mentor.com>
 <1383303131-29550-4-git-send-email-dmitry_eremin@mentor.com>
 <20131101105933.GL16735@n2100.arm.linux.org.uk>
Message-ID: <5274070D.1030206@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/13 14:59, Russell King - ARM Linux wrote:
> On Fri, Nov 01, 2013 at 02:52:11PM +0400, Dmitry Eremin-Solenikov wrote:
>> +#include <linux/kernel.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/clkdev.h>
>> +
>> +#include <mach/hardware.h>
> 
> If the aim of this patch set is to move SA11x0 towards multiplatform,
> then this has just failed with the above include.  It would be better
> not to try this without first solving the problem of the SoC register
> definitions.

Also what about first three patches?


-- 
With best wishes
Dmitry
