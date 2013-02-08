From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 8 Feb 2013 21:06:11 +0530
Subject: [PATCH] ARM: OMAP2+: PM: Fix the dt return condition in
 pm_late_init()
In-Reply-To: <alpine.DEB.2.00.1302081533270.28008@utopia.booyaka.com>
References: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1302081533270.28008@utopia.booyaka.com>
Message-ID: <51151B6B.9000505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 February 2013 09:04 PM, Paul Walmsley wrote:
> On Fri, 8 Feb 2013, Santosh Shilimkar wrote:
>
>> Commit 1416408d {ARM: OMAP2+: PM: share some suspend-related functions
>> across OMAP2, 3, 4} moved suspend code to common place but now with
>> that change, for DT build on OMAP4, suspend hooks are not getting
>> registered which results in no suspend support.
>>
>> The DT return condition is limited to PMIC and smartreflex
>> initialization and hence restrict it so that suspend ops gets
>> registered.
>>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Thanks, queued here with Felipe's Reviewed-by: along with the other OMAP4
> PM fixes.
>
Thanks Paul !!

Regards,
Santosh
