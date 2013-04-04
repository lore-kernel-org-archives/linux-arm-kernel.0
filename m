From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 4 Apr 2013 19:18:04 +0530
Subject: [PATCH v2 13/18] ARM: OMAP: CPUidle: Unregister drivere on device
 registration failure
In-Reply-To: <871uartjgg.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
 <1364205910-32392-14-git-send-email-santosh.shilimkar@ti.com>
 <871uartjgg.fsf@linaro.org>
Message-ID: <515D8494.20305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 April 2013 02:33 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> If the CPUidle device registration fails for some reason, we should
>> unregister the driver on error path.
>>
>> Fix the code accordingly. Also when at it, check of the driver registration
>> failure too.
>>
>> Acked-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Adding to my for_3.10/fixes/cpuidle branch.
> 
Thanks.

regards,
Santosh
