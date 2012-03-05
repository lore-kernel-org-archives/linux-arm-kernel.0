From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 05 Mar 2012 17:43:07 +0100
Subject: [PATCH v7 0/9] Consolidate cpuidle functionality
In-Reply-To: <CAMXH7KGJtSyeGwEN4jz9TRPxHUjtreMHRG-4WDChB0BC88P=OA@mail.gmail.com>
References: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
 <CAMXH7KGJtSyeGwEN4jz9TRPxHUjtreMHRG-4WDChB0BC88P=OA@mail.gmail.com>
Message-ID: <4F54ED1B.3070404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2012 09:57 PM, Rob Lee wrote:
> On Wed, Feb 29, 2012 at 6:42 PM, Robert Lee<rob.lee@linaro.org>  wrote:
>> This patch series moves various functionality duplicated in platform
>> cpuidle drivers to the core cpuidle driver. Also, the platform irq
>> disabling was removed as it appears that all calls into
>> cpuidle_call_idle will have already called local_irq_disable().
>>
>
> I'm told that I forgot to add the Acks from the previous v6 to this version:
>
> Acked-by: Jean Pihet<j-pihet@ti.com>  (v6)
> Tested-by: Jean Pihet<j-pihet@ti.com>  (v6, omap3)
> Tested-by: Amit Daniel<amit.kachhap@linaro.org>  (v6, Exynos4)
> For the generic cpuidle changes:
> Reviewed-by: Deepthi Dharwar<deepthi@linux.vnet.ibm.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
