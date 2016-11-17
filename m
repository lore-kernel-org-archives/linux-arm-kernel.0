From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 17 Nov 2016 14:16:06 -0800
Subject: [PATCH] ARM: dts: qcom: Add apq8064 CoreSight components
In-Reply-To: <20161117153609.11705-1-georgi.djakov@linaro.org>
References: <20161117153609.11705-1-georgi.djakov@linaro.org>
Message-ID: <d466f591-baac-c734-a49b-8aab763c1876@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2016 07:36 AM, Georgi Djakov wrote:
> From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
>
> Add initial set of CoreSight components found on Qualcomm's
> 8064 chipset.
>
> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8064-coresight.dtsi | 196 ++++++++++++++++++++++++++

Why not put this inside the soc file? This would be the first time we
add a new file for something that's inside the SoC node that probably
won't change thereafter. At least for pins I slightly agree with having
a different file, we're adding more and more things there so it's nice
to have a consolidated place of all possible configurations to choose
from. But here it's mostly a static device description so what's the gain?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
