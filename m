From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Wed, 2 Sep 2015 17:55:09 +0530
Subject: [PATCH 1/2] mmc: sdhci-pxav3: Fix tabbing issue
In-Reply-To: <1441139486.12163.3.camel@perches.com>
References: <1441135454-6902-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441135454-6902-2-git-send-email-vaibhav.hiremath@linaro.org>
 <1441139486.12163.3.camel@perches.com>
Message-ID: <55E6EAA5.4030808@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 02 September 2015 02:01 AM, Joe Perches wrote:
> On Wed, 2015-09-02 at 00:54 +0530, Vaibhav Hiremath wrote:
>> There were some coding style issues where spaces have been used instead
>> of tabs, for example, in macro definitions, alignment of function
>> declarations/definitions, etc...
>>
>> This patch fixes all such occurrences in the code.
>> And also use BIT for bit definitions.
>
> Please send 2 patches instead.
>
>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> []
>> @@ -128,7 +133,7 @@ static int mv_conf_mbus_windows(struct platform_device *pdev,
>>   }
>>
>>   static int armada_38x_quirks(struct platform_device *pdev,
>> -			     struct sdhci_host *host)
>> +			struct sdhci_host *host)
>
> This is not an improvement.
>

Missed to highlight one more point here,

The kernel CodingStyle talks about indentation, pasting it below -

-------
Outside of comments, documentation and except in Kconfig, spaces are
never used for indentation.
-------

But I see spaces are being used at lot of places :)

Till now all the patches or drivers which I submitted, I never used
spaces. :)
Anyway, just wanted to highlight CodingStyle document here.

Thanks,
Vaibhav
