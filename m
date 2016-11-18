From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Fri, 18 Nov 2016 14:36:44 +0200
Subject: [PATCH] ARM: dts: qcom: Add apq8064 CoreSight components
In-Reply-To: <d466f591-baac-c734-a49b-8aab763c1876@codeaurora.org>
References: <20161117153609.11705-1-georgi.djakov@linaro.org>
 <d466f591-baac-c734-a49b-8aab763c1876@codeaurora.org>
Message-ID: <fda017e4-2902-359e-dad4-b0efd9ebeeb9@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2016 12:16 AM, Stephen Boyd wrote:
> On 11/17/2016 07:36 AM, Georgi Djakov wrote:
>> From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
>>
>> Add initial set of CoreSight components found on Qualcomm's
>> 8064 chipset.
>>
>> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  arch/arm/boot/dts/qcom-apq8064-coresight.dtsi | 196 ++++++++++++++++++++++++++
>
> Why not put this inside the soc file? This would be the first time we
> add a new file for something that's inside the SoC node that probably
> won't change thereafter. At least for pins I slightly agree with having
> a different file, we're adding more and more things there so it's nice
> to have a consolidated place of all possible configurations to choose
> from. But here it's mostly a static device description so what's the gain?

Ok, after thinking more about this and looking at other soc dtsi files i 
agree with you. Will update!

Thanks!
Georgi
