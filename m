From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 4 Apr 2013 19:17:30 +0530
Subject: [PATCH v2 12/18] ARM: OMAP4: CPUidle: Avoid double idle driver
 registration
In-Reply-To: <877gkjtjht.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
 <1364205910-32392-13-git-send-email-santosh.shilimkar@ti.com>
 <877gkjtjht.fsf@linaro.org>
Message-ID: <515D8472.4030204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 April 2013 02:33 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> OMAP4 CPUidle driver registration call is under a loop which leads
>> to calling cpuidle_register_driver twice which is not intended.
>>
>> Fix it by moving the driver registration outside the loop.
>>
>> Reported-by: Nishanth Menon <nm@ti.com>
>> Acked-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Looks good.
> 
> I've already got a for_3.10/fixes/cpuidle branch going, so I'll apply
> this one there.
> 
ok.

Regards,
Santosh
