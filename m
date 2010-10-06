From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 05 Oct 2010 20:36:44 -0700
Subject: [PATCH 2/3] [ARM] Allow machines to override __delay()
In-Reply-To: <1286299778.18791.18.camel@c-dwalke-linux.qualcomm.com>
References: <1285644827-6846-1-git-send-email-sboyd@codeaurora.org>	<1285644827-6846-3-git-send-email-sboyd@codeaurora.org>
	<1286299778.18791.18.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <4CABEECC.6060703@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 On 10/05/2010 10:29 AM, Daniel Walker wrote:
>> diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
>> index 5ee0adc..b307fcc 100644
>> --- a/arch/arm/lib/delay.c
>> +++ b/arch/arm/lib/delay.c
>> @@ -3,6 +3,8 @@
>>   *
>>   *  Copyright (C) 1995, 1996 Russell King
>>   *  Copyright (c) 2010, Code Aurora Forum. All rights reserved.
>> + *  Copyright (C) 1993 Linus Torvalds
>> + *  Copyright (C) 1997 Martin Mares <mj@atrey.karlin.mff.cuni.cz>
> Who is Martin Mares? Why are you adding these?

These are the respective copyrights from x86's delay.c for the code I
copied. I'll see if they can be dropped.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
