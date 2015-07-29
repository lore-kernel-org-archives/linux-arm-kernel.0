From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 29 Jul 2015 09:55:22 +0100
Subject: [PATCH v9 0/9] Add simple NVMEM Framework via regmap.
In-Reply-To: <55B893A7.2030206@codeaurora.org>
References: <1437995567-11203-1-git-send-email-srinivas.kandagatla@linaro.org>
 <55B893A7.2030206@codeaurora.org>
Message-ID: <55B894FA.8050008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/07/15 09:49, Rajendra Nayak wrote:
> On 07/27/2015 04:42 PM, Srinivas Kandagatla wrote:
>> Hi Greg/Kevin,
>>
>> This patchset adds a new simple NVMEM framework to kernel, and it is
>> tested
>> with various drivers like "QCOM thermal sensors", "QCOM cpr driver",
>> "begal bone cape manager" and few more on the way.
>>
>> Can you please consider this as 4.3 material, AFAIK there are more
>> than 3 drivers
>> depending on this framework which are wating since last 2 merge windows.
>
> I have been testing these with the qcom tsens driver, and did test v9
> as well, so feel free to add my tested by for the entire series,
>
> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>

Thanks Rajendra for the tested-by.
