From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Jul 2015 15:13:19 -0700
Subject: [PATCH 2/4] mfd: devicetree: bindings: Add clock subdevice node
 information
In-Reply-To: <CAJKOXPeUJ-7je67q+9X1_FcFiczoQ6rqwMAoPLswapFEmqGGVg@mail.gmail.com>
References: <1437476823-3358-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437476823-3358-3-git-send-email-vaibhav.hiremath@linaro.org>
 <CAJKOXPeUJ-7je67q+9X1_FcFiczoQ6rqwMAoPLswapFEmqGGVg@mail.gmail.com>
Message-ID: <55BAA17F.1070305@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2015 10:08 PM, Krzysztof Kozlowski wrote:
> 2015-07-21 20:07 GMT+09:00 Vaibhav Hiremath <vaibhav.hiremath@linaro.org>:
>> This patch updates the binding documentation for optional
>> clocks node and related information for buffered 32KHz clock.
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/mfd/88pm800.txt | 28 +++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
> +Cc Stephen Boyd (clocks)
>
> We had a discussion whether clock bindings should be put in MFD
> bindings documentation or into separate file in bindings/clock but
> either way is fine for me:

No patch? :)

I think Rob has been pushing for MFDs to document everything within one 
file, but either way is fine from clk perspective.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
