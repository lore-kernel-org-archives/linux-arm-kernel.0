From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 4 Apr 2013 19:18:19 +0530
Subject: [PATCH v2 14/18] ARM: OMAP4: CPUidle: Make C-state description
 field more precise
In-Reply-To: <87vc83s4sv.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
 <1364205910-32392-15-git-send-email-santosh.shilimkar@ti.com>
 <87vc83s4sv.fsf@linaro.org>
Message-ID: <515D84A3.6070007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 April 2013 02:35 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> It is useful to know the CPU power state along with MPUSS power state
>> in a supported C-state. Since the data is available via sysfs, one can
>> avoid scrolling the source code for precise construction of C-state.
>>
>> Reported-by: Nishanth Menon <nm@ti.com>
>> Acked-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Nice.
> 
> Adding to for_3.10/fixes/cpuidle branch.
> 
Thanks.

regards,
Santosh
