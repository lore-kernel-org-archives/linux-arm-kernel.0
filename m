From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 18 Dec 2015 20:27:36 +0800
Subject: [PATCH v10 0/4] irqchip:support mbigen interrupt controller
In-Reply-To: <5673F4D0.9050608@arm.com>
References: <1450353397-47668-1-git-send-email-majun258@huawei.com>
 <5673F4D0.9050608@arm.com>
Message-ID: <5673FBB8.7000307@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc, Mark,

On 2015/12/18 19:58, Marc Zyngier wrote:
> On 17/12/15 11:56, MaJun wrote:
>> From: Ma Jun <majun258@huawei.com>
>>
>> This patch set adds the driver of mbigen and binding document for Hisilicon
>> Mbigen chips.
> [...]
>
> I've reworked the nits noticed by Mark and stashed this in my
> irq/wire-msi-bridge branch.

I'm also following this patch set and I checked your tree in irq/wire-msi-bridge
branch, especially with the "num-pins" property/driver update, I think the code
in your tree is in good shape, thanks a lot for the review!

Thanks
Hanjun
