From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 17 Jan 2017 14:55:32 +0000
Subject: [PATCH v4 4/4] arm64: dts: juno: add missing CoreSight STM
 component
In-Reply-To: <DB6PR0802MB2198D30880E268077202AAD88C7C0@DB6PR0802MB2198.eurprd08.prod.outlook.com>
References: <1484655313-9025-1-git-send-email-sudeep.holla@arm.com>
 <1484655313-9025-5-git-send-email-sudeep.holla@arm.com>
 <5c742b98-0707-67fd-d8a1-467f34d99cdb@arm.com>
 <6473418b-95d5-5be3-47fd-4c554f353923@arm.com>
 <DB6PR0802MB2198D30880E268077202AAD88C7C0@DB6PR0802MB2198.eurprd08.prod.outlook.com>
Message-ID: <85365bbd-7512-2a39-3698-f9a583334ee7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/01/17 14:52, Mike Leach wrote:

[...]

>> 
>> Mike,
>> 
>> Can you confirm ? I know TRM had some issues with size of other 
>> coresight components.
>> 
> Checked both Juno and STM arch manuals - these are in agreement that
> the STM memory stimulus area is 16MB in size. Thus for Juno
> specifically with all masters seeing the same area @ base 0x28000000,
> <0 0x28000000 0 0x1000000 >  would be the correct description.
> 

Thanks for the confirmation, I have already made the changes in [1]

-- 
Regards,
Sudeep

[1] git.kernel.org/sudeep.holla/linux/h/for-next/updates/juno
