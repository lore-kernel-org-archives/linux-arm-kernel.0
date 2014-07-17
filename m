From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Thu, 17 Jul 2014 09:13:37 -0500
Subject: [PATCH] irqchip: gic: Add binding probe for ARM GIC400
In-Reply-To: <20140717124804.GI13108@titan.lakedaemon.net>
References: <1404947104-21345-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1404947104-21345-2-git-send-email-suravee.suthikulpanit@amd.com>
 <2932284.F1eaAf8ArJ@diego> <2621565.f5eISveXXJ@diego>
 <20140717124804.GI13108@titan.lakedaemon.net>
Message-ID: <53C7DA11.2000105@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/17/2014 7:48 AM, Jason Cooper wrote:
> On Tue, Jul 15, 2014 at 12:03:03AM +0200, Heiko St?bner wrote:
>> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>
>> Commit 3ab72f9156bb "dt-bindings: add GIC-400 binding" added the
>> "arm,gic-400" compatible string, but the corresponding IRQCHIP_DECLARE
>> was never added to the gic driver.
>>
>> Therefore add the missing irqchip declaration for it.
>>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>
>> Removed additional empty line and adapted commit message to mark it
>> as fixing an issue.
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>> As I really need this, I took the liberty of adapting the patch accordingly
>> to make it apply on top of the current irqchip/for-next (or urgent) and
>> explicitly state the fixed issue. Hope that is ok
>>
>>   drivers/irqchip/irq-gic.c | 1 +
>>   1 file changed, 1 insertion(+)
>
> Applied to irqchip/urgent with Will's Ack and Cc'd to stable for v3.14+
>
> thx,
>
> Jason.
>
Thank you,

Suravee
