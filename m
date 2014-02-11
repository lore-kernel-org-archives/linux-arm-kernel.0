From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 11 Feb 2014 09:13:23 -0600
Subject: [PATCH v3 3/5] ARM: qcom: Split Qualcomm support into legacy and
 multiplatform
In-Reply-To: <20140208032607.GC10784@codeaurora.org>
References: <1391725484-6673-1-git-send-email-galak@codeaurora.org>
 <1391725484-6673-4-git-send-email-galak@codeaurora.org>
 <20140208032607.GC10784@codeaurora.org>
Message-ID: <392A0D29-65A3-403D-B645-DB74A1897170@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Feb 7, 2014, at 9:26 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 02/06, Kumar Gala wrote:
>> diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-qcom/platsmp.c
>> similarity index 98%
>> rename from arch/arm/mach-msm/platsmp.c
>> rename to arch/arm/mach-qcom/platsmp.c
>> index 251a91e..67823a7 100644
>> --- a/arch/arm/mach-msm/platsmp.c
>> +++ b/arch/arm/mach-qcom/platsmp.c
>> @@ -2,6 +2,7 @@
>>  *  Copyright (C) 2002 ARM Ltd.
>>  *  All Rights Reserved
>>  *  Copyright (c) 2010, Code Aurora Forum. All rights reserved.
>> + *  Copyright (c) 2014 The Linux Foundation. All rights reserved.
> 
> We should replace the Code Aurora Forum copyright with Linux
> Foundation here.

Is this something we?ve been doing?  Its normally bad form to make such changes, but I don?t know what the details re when LF took over CAF w/regards to something like Copyright.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
