From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri, 10 May 2013 12:17:35 +0530
Subject: [PATCH] ARM: dts: add max8997 device node for exynos4210-origen
 board
In-Reply-To: <50EA598D.6090604@linaro.org>
References: <1353664412-17678-1-git-send-email-thomas.abraham@linaro.org>
 <50EA598D.6090604@linaro.org>
Message-ID: <518C9807.80906@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/2013 10:43 AM, Tushar Behera wrote:
> On 11/23/2012 03:23 PM, Thomas Abraham wrote:
>> Add max8997 regulator device node for exynos4210-origen board and list
>> all the supported regulators.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> 
> Tested-by: Tushar Behera <tushar.behera@linaro.org>
> 
Kukjin,

This patch got missed for 3.10 merge window. This patch still applies on
the latest mainline kernel and is essential for Origen board. Would you
please take this patch?

-- 
Tushar Behera
