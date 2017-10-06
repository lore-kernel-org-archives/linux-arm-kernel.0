From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 6 Oct 2017 09:53:06 +0100
Subject: [PATCH 2/2] firmware: arm_scpi: remove all single element
 structures
In-Reply-To: <18e4e7d1-69e8-0176-b823-4de102973ef5@gmail.com>
References: <1507201911-27976-1-git-send-email-sudeep.holla@arm.com>
 <1507201911-27976-2-git-send-email-sudeep.holla@arm.com>
 <18e4e7d1-69e8-0176-b823-4de102973ef5@gmail.com>
Message-ID: <e3fd0668-f23b-6da5-ee0c-0ef146ec4d7b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/10/17 20:07, Heiner Kallweit wrote:
> Am 05.10.2017 um 13:11 schrieb Sudeep Holla:
>> Both clk_get_value and sensor_value structures contains a single element
>> and hence needs no packing making the whole structure defination
>> unnecessary.
>>
>> This patch gets rid of both those structures
>>
>> Cc: Heiner Kallweit <hkallweit1@gmail.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

[..]

>>
> Looks good to me.

Thanks. Tested-by or Reviewed-by would help ;)


-- 
Regards,
Sudeep
