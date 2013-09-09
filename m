From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Mon, 09 Sep 2013 14:42:10 -0700
Subject: [PATCHv3 1/2] ARM: msm: Add support for APQ8074 Dragonboard
In-Reply-To: <CA05A23E-41CF-4EC6-BB2D-36105048700B@codeaurora.org>
References: <1378495943-2572-1-git-send-email-rvaswani@codeaurora.org>
 <20130906215051.GA29253@quad.lixom.net> <522E09E6.8040300@codeaurora.org>
 <FFE100A7-8AD6-4E0D-9F64-120DA3564F89@codeaurora.org>
 <522E21A8.4060408@wwwdotorg.org>
 <FA33E8F4-3F85-4D8B-83E1-96F5A8F76CE6@codeaurora.org>
 <522E3BC9.1030105@wwwdotorg.org>
 <CA05A23E-41CF-4EC6-BB2D-36105048700B@codeaurora.org>
Message-ID: <522E40B2.9010301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/9/2013 2:25 PM, Kumar Gala wrote:
> <snip>
> On Fri, Sep 06, 2013 at 12:32:22PM -0700, Rohit Vaswani wrote:
>>>>>>>> This patch adds basic board support for APQ8074 Dragonboard
>>>>>>>> <snip>
>>>>>>>> dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
>>>>>>>> -	msm8960-cdp.dtb
>>>>>>>> +	msm8960-cdp.dtb \
>>>>>>>> +	apq8074-dragonboard.dtb
>>>>>>> Please add boards alphabetically.
>>>>>> Will do.
>>>>>>>> dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
>>>>>>>> 	armada-370-mirabox.dtb \
>>>>>>>> 	armada-370-rd.dtb \
>>>>>>>> diff --git a/arch/arm/boot/dts/apq8074-dragonboard.dts b/arch/arm/boot/dts/apq8074-dragonboard.dts
>>>>>>>> new file mode 100644
>>>>>>>> index 0000000..5b7b6a0
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/arch/arm/boot/dts/apq8074-dragonboard.dts
>>>>>>> arch/arm/boot/dts/ is getting really crowded. It's been working best if the SoC
>>>>>>> family or vendor is used as a prefix to keep things a bit more organized. In
>>>>>>> that spirit, prefixing these with msm-<foo> makes sense. Can you please do so?
>>>>>> Sure. But the board is called an APQ8074 and we wanted to keep the naming consistent with that.
>>>>> If we do this we should use qcom, not msm as the prefix.  Match the device tree vendor prefix.

Coming back to this, it would be better if the naming to be consistent 
with what we call our ARCH - msm and not qcom.
msm8974-dragonboard signifies quite clearly what the board is.

>>>> <snip> 


Thanks,
Rohit Vaswani

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation
