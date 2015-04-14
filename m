From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 14 Apr 2015 14:41:13 -0500
Subject: [RFC PATCH 4/5] arm64: smp: move the pen to a header file
In-Reply-To: <6018110.XP6YK3PMra@wuerfel>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <1428601031-5366-5-git-send-email-galak@codeaurora.org>
 <6018110.XP6YK3PMra@wuerfel>
Message-ID: <ADC5226F-26FA-426B-A6EE-77D56BFFDFAE@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Apr 9, 2015, at 4:17 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> On Thursday 09 April 2015 12:37:10 Kumar Gala wrote:
>> From: Abhimanyu Kapur <abhimany@codeaurora.org>
>> 
>> Move the secondary_pen_release variable and the secondary_holding_pen
>> entry function to asm/smp_plat.h so that the other cpu ops implementations
>> can share them.
>> 
>> Signed-off-by: Abhimanyu Kapur <abhimany@codeaurora.org>
>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>> 
> 
> I don't believe your SMP implementation can be so broken to require this.
> Please fix the code instead to not use a holding pen.
> 
> 	Arnd

Yeah, I can drop this.

- k

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
