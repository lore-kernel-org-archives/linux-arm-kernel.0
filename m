From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 09 Dec 2014 15:05:42 +0100
Subject: [PATCH] clk: samsung: Fix Exynos 5420 pinctrl setup and clock
 disable failure due to domain being gated
In-Reply-To: <5486F69B.6020005@samsung.com>
References: <1417788934-23447-1-git-send-email-k.kozlowski@samsung.com>
 <1418129982.19339.6.camel@AMDC1943> <5486F69B.6020005@samsung.com>
Message-ID: <548701B6.2030902@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 12/09/2014 02:18 PM, Sylwester Nawrocki wrote:
>> 
>> This is a non-intrusive workaround for that issue, as wanted by
>> Sylwester:
>> https://lkml.org/lkml/2014/12/5/223
>> 
>> Any comments on this?
> 
> The patch looks OK to me, it would be good though if someone else
> has confirmed it fixes the bug. I don't have any clock patches queued
> at the moment. Perhaps you could apply it directly, Mike ?
> 

This patch fixes the boot failure bug on my Exynos5420 Peach Pit
Chromebook and I've audio working as well.

> From my side:
> 
> Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
