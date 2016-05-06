From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 06 May 2016 08:20:15 +0200
Subject: [RFC v2 05/13] power: pwrseq: Remove mmc prefix from mmc_pwrseq
In-Reply-To: <48539995-2966-0df0-51db-e0c549a92880@osg.samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <1462451666-17945-6-git-send-email-k.kozlowski@samsung.com>
 <48539995-2966-0df0-51db-e0c549a92880@osg.samsung.com>
Message-ID: <572C379F.6030504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2016 09:09 PM, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 05/05/2016 08:34 AM, Krzysztof Kozlowski wrote:
>> The "mmc" prefix is no longer needed after moving the pwrseq core code
>> from mmc/ to power/.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
> 
> [snip]
> 
>> diff --git a/drivers/power/pwrseq/pwrseq_emmc.c b/drivers/power/pwrseq/pwrseq_emmc.c
>> index a0583ed46d7f..a68ac9a68e04 100644
>> --- a/drivers/power/pwrseq/pwrseq_emmc.c
>> +++ b/drivers/power/pwrseq/pwrseq_emmc.c
>> @@ -22,7 +22,7 @@
>>  #include <linux/mmc/host.h>
>>
> 
> I don't think this header inclusion is needed. At least I didn't see anything
> defined there that's used in this driver. This also applies to pwrseq_simple.
> 
> I think you could remove those in another preparatory patches before the move.
>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Good catch, thanks.

BR,
Krzysztof
