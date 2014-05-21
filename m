From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 21 May 2014 14:14:29 -0500
Subject: [PATCH v1 4/4] ARM: debug: qcom: Add APQ8084 DEBUG_LL UART support
In-Reply-To: <1400686086.856.15.camel@iivanov-dev>
References: <1400684225-21381-1-git-send-email-gdjakov@mm-sol.com>
 <1400684225-21381-5-git-send-email-gdjakov@mm-sol.com>
 <4365639.JcFl1cP048@wuerfel> <1400686086.856.15.camel@iivanov-dev>
Message-ID: <A9A4B705-E550-407D-BDAD-91083417B356@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On May 21, 2014, at 10:28 AM, Ivan T. Ivanov <iivanov@mm-sol.com> wrote:

> Hi, 
> 
> On Wed, 2014-05-21 at 17:18 +0200, Arnd Bergmann wrote:
>> On Wednesday 21 May 2014 17:57:05 Georgi Djakov wrote:
> 
>>> 
>>> +#ifdef CONFIG_DEBUG_APQ8084_UART
>>> +#define MSM_DEBUG_UART_BASE    0xFA75E000
>>> +#define MSM_DEBUG_UART_PHYS    0xF995E000
>>> +#endif
>>> +
> 
>> Maybe we should move debug/msm.S over to use
>> CONFIG_DEBUG_UART_PHYS/CONFIG_DEBUG_UART_VIRT now?
>> 
> 
> There is patch which do this [1]. It was reviewed 
> by Stephen Boyd [2].
> 
> Regards,
> Ivan
> 
> 
> [1] https://lkml.org/lkml/2014/4/14/312
> [2] https://lkml.org/lkml/2014/4/14/542

I?ll grab Ivan?s patch and send via my qcom tree to arm-soc.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
