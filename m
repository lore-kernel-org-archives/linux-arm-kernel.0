From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 12 May 2015 20:58:32 +0530
Subject: [PATCH] phy: qcom-ufs: Switch dependency to ARCH_QCOM
In-Reply-To: <cc0696254c2adcd911f1dd77c5886ba0.squirrel@www.codeaurora.org>
References: <1428707466-24526-3-git-send-email-sboyd@codeaurora.org>
 <42019bf2314bad314c737a10f9c7628b.squirrel@www.codeaurora.org>
 <cc0696254c2adcd911f1dd77c5886ba0.squirrel@www.codeaurora.org>
Message-ID: <55521C20.9030305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 12 May 2015 12:49 PM, ygardi at codeaurora.org wrote:
> I'd change the tag to Reviewed-by.
>
> looks-good.
>
> Reviewed-by: Yaniv Gardi <ygardi@codeaurora.org>

updated the linux-phy tree with this.

Cheers
Kishon
>
>
>> looks good.
>>
>> Acked-by: Yaniv Gardi <ygardi@codeaurora.org>
>>
>>
>>> This phy only exists on platforms under ARCH_QCOM, not ARCH_MSM.
>>>
>>> Cc: Yaniv Gardi <ygardi@codeaurora.org>
>>> Cc: Dov Levenglick <dovl@codeaurora.org>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Cc: David Brown <davidb@codeaurora.org>
>>> Cc: Bryan Huntsman <bryanh@codeaurora.org>
>>> Cc: Daniel Walker <dwalker@fifo99.com>
>>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>>> ---
>>>   drivers/phy/Kconfig | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>>> index 2962de205ba7..9b1ff313bd51 100644
>>> --- a/drivers/phy/Kconfig
>>> +++ b/drivers/phy/Kconfig
>>> @@ -286,7 +286,7 @@ config PHY_STIH41X_USB
>>>
>>>   config PHY_QCOM_UFS
>>>   	tristate "Qualcomm UFS PHY driver"
>>> -	depends on OF && ARCH_MSM
>>> +	depends on OF && ARCH_QCOM
>>>   	select GENERIC_PHY
>>>   	help
>>>   	  Support for UFS PHY on QCOM chipsets.
>>> --
>>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
>>> Forum,
>>> a Linux Foundation Collaborative Project
>>>
>>>
>>
>>
>
>
