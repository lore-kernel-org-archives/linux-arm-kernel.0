From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Thu, 08 Aug 2013 15:17:25 -0700
Subject: [PATCH] [TRIVIAL] ARM: msm: fix compilation error in gpiomux
In-Reply-To: <1375943536.30982.1.camel@AMDC1943>
References: <1375857279-18082-1-git-send-email-k.kozlowski@samsung.com>
 <20130807174053.GA17551@codeaurora.org>
 <20130807210804.GB14845@codeaurora.org> <1375943536.30982.1.camel@AMDC1943>
Message-ID: <520418F5.2030804@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/7/2013 11:32 PM, Krzysztof Kozlowski wrote:
> On ?ro, 2013-08-07 at 14:08 -0700, Stephen Boyd wrote:
>> On 08/07, David Brown wrote:
>>> On Wed, Aug 07, 2013 at 08:34:39AM +0200, Krzysztof Kozlowski wrote:
>>>> Fix compilation error in gpiomux (CONFIG_MSM_GPIOMUX=y):
>>>> arch/arm/mach-msm/gpiomux.c:24:13: error: static declaration of
>>>> 	???__msm_gpiomux_write??? follows non-static declaration
>>>> arch/arm/mach-msm/gpiomux.h:85:6: note: previous declaration of
>>>> 	???__msm_gpiomux_write??? was here
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>> Thanks, I'll pull this in.
>>>
>>>   <https://patchwork.kernel.org/patch/2839921/>
>>>
>> I believe this is fixed by Rohit's patch that has already been
>> taken in a pull request?
>>
>> https://lkml.org/lkml/2013/7/26/608
> Yes, Rohit's patch fixes the problem so this is already in linux-msm
> tree.
>

David, please can you confirm which pull request has this patch ?
> Best regards,
> Krzysztof
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


Thanks,
Rohit Vaswani

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation
