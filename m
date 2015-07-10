From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Fri, 10 Jul 2015 17:37:13 +0530
Subject: [PATCH 2/3] regulator: 88pm800: fix LDO vsel_mask value
In-Reply-To: <20150709190459.GP11162@sirena.org.uk>
References: <1436445692-10656-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436445692-10656-3-git-send-email-vaibhav.hiremath@linaro.org>
 <20150709190459.GP11162@sirena.org.uk>
Message-ID: <559FB571.9030302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 10 July 2015 12:34 AM, Mark Brown wrote:
> On Thu, Jul 09, 2015 at 06:11:31PM +0530, Vaibhav Hiremath wrote:
>> From: Yi Zhang <yizhang@marvell.com>
>>
>> As per datasheet,
>> Except LDO2, all other LDO's use bit [3:0] for VOUT select.
>
> Bug fixes like this should come at the start of the series before new
> functionality so they can be merged as bug fixes into Linus' tree and
> -stable.
>

You are right.
Will take care from next time onwards.

Thanks,
Vaibhav
