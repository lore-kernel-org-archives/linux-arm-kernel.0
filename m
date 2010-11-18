From: janakiram.sistla@gmail.com (Janakiram Sistla)
Date: Thu, 18 Nov 2010 14:02:09 -0800
Subject: [PATCH v4 2/2] msm: gpio: Add irq support to v2 gpiolib.
In-Reply-To: <alpine.DEB.2.00.1011181256470.29924@gbean-linux.qualcomm.com>
References: <1290109970-26752-1-git-send-email-gbean@codeaurora.org>
	<1290109970-26752-2-git-send-email-gbean@codeaurora.org>
	<AANLkTimTsyhjHJZggFO31C-2RswpmKWn-V4pGEiQ3+_2@mail.gmail.com>
	<alpine.DEB.2.00.1011181229380.26784@gbean-linux.qualcomm.com>
	<AANLkTi=p02P=-JQ9+FynFyM1yxrAh3utKTD2uzqhnLxK@mail.gmail.com>
	<alpine.DEB.2.00.1011181256470.29924@gbean-linux.qualcomm.com>
Message-ID: <AANLkTiknYmWOmiFXGp6h2dT==aMuGs3BtXi82b6Vdq5i@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 18, 2010 at 12:59 PM, Gregory Bean <gbean@codeaurora.org> wrote:
>>>> Do you mean to MSM have v1 and v2 gpio hardware ??? can not we
>>>> have one file under mach-msm as gpio.c??
>>>
>>> The MSM8x60 is the first MSM chip to carry the second-generation, or v2,
>>> GPIO hardware block. ?This block is not backward compatible with the
>>> v1 block found on older MSMs, so the two drivers cannot be elegantly
>>> merged.
>>
>> so this is applicable to 8x60 and coming chip sets.I basically have a
>> question,How come a a new person under stand the ?chipset uses gpio-v1
>> or gpiov2??
>
> Targets with the v2 block define CONFIG_MSM_V2_TLMM.
So in that case we can name  it as gpio-tlmm.c ??
> --
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
