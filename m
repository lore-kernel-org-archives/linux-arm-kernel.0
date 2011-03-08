From: nm@ti.com (Nishanth Menon)
Date: Tue, 08 Mar 2011 05:47:04 +0530
Subject: [PATCH v3] OMAP3+: OPP: Replace voltage values with Macros
In-Reply-To: <874o7e1ss2.fsf@ti.com>
References: <1299320842-2503-1-git-send-email-nm@ti.com>
	<874o7e1ss2.fsf@ti.com>
Message-ID: <4D757580.6050507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman wrote, on 03/08/2011 03:45 AM:
> Nishanth Menon<nm@ti.com>  writes:
>
>> From: Vishwanath BS<vishwanath.bs@ti.com>
>>
>> Since all voltage data is now centralized in oppxxx_data.c, we can replace
>> the values in the opp table with the macros used for voltage values.
>>
>> This will avoid opp table and voltage layer having conflicting values.
>>
>> Signed-off-by: Vishwanath BS<vishwanath.bs@ti.com>
>
> As you are now on the delivery path too, this should have your sign-off.
>
> Assuming this is a simple oversight, I added your signoff and queued for
> 2.6.39 (branch: for_2.6.39/pm-misc)

thanks.

-- 
Regards,
Nishanth Menon
