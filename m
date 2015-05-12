From: ygardi@codeaurora.org (ygardi at codeaurora.org)
Date: Tue, 12 May 2015 07:20:24 -0000
Subject: [PATCH] ufs-qcom: Switch dependency to ARCH_QCOM
In-Reply-To: <1730be19bac4946d9c15fa7c99cfbbc0.squirrel@www.codeaurora.org>
References: <1428707466-24526-5-git-send-email-sboyd@codeaurora.org>
 <1730be19bac4946d9c15fa7c99cfbbc0.squirrel@www.codeaurora.org>
Message-ID: <9e7a75b3e508f29e0fb350ef853ce229.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'd change the tag to Reviewed-by.

looks-good.

Reviewed-by: Yaniv Gardi <ygardi@codeaurora.org>


> looks good.
>
> Acked-by: Yaniv Gardi <ygardi@codeaurora.org>
>
>
>> This device only exists on platforms under ARCH_QCOM, not
>> ARCH_MSM.
>>
>> Cc: Yaniv Gardi <ygardi@codeaurora.org>
>> Cc: Dov Levenglick <dovl@codeaurora.org>
>> Cc: Vinayak Holikatti <vinholikatti@gmail.com>
>> Cc: David Brown <davidb@codeaurora.org>
>> Cc: Bryan Huntsman <bryanh@codeaurora.org>
>> Cc: Daniel Walker <dwalker@fifo99.com>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>  drivers/scsi/ufs/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
>> index 8a1f4b355416..e94538362536 100644
>> --- a/drivers/scsi/ufs/Kconfig
>> +++ b/drivers/scsi/ufs/Kconfig
>> @@ -73,7 +73,7 @@ config SCSI_UFSHCD_PLATFORM
>>
>>  config SCSI_UFS_QCOM
>>  	bool "QCOM specific hooks to UFS controller platform driver"
>> -	depends on SCSI_UFSHCD_PLATFORM && ARCH_MSM
>> +	depends on SCSI_UFSHCD_PLATFORM && ARCH_QCOM
>>  	select PHY_QCOM_UFS
>>  	help
>>  	  This selects the QCOM specific additions to UFSHCD platform driver.
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
>> Forum,
>> a Linux Foundation Collaborative Project
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
