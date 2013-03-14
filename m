From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 14 Mar 2013 17:16:56 +0530
Subject: OMAP baseline test results for v3.9-rc1
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC281B4@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EC281B4@DBDE01.ent.ti.com>
Message-ID: <5141B8B0.5050206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 March 2013 04:59 PM, Hiremath, Vaibhav wrote:
> 
>> -----Original Message-----
>> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
>> owner at vger.kernel.org] On Behalf Of Paul Walmsley
>> Sent: Tuesday, March 12, 2013 10:10 PM
>> To: linux-omap at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Subject: OMAP baseline test results for v3.9-rc1
>>
>>
>> Here are some basic OMAP test results for Linux v3.9-rc1.
>> Logs and other details at:
>>
>>     http://www.pwsan.com/omap/testlogs/test_v3.9-rc1/20130312100243/
>>
>>
>> Test summary
>> ------------
>>
>> Build:
>>     FAIL ( 4/16): am33xx_only, omap1_defconfig,
> This requires some cleanup in Makefile and Kconfig handling,
> 
> Either you disable SMP support for non-SMP devices like AM33xx 
> 
> OR
> 
> Fix the Makefile to resolve the build dependencies (may not be trivial)
> 
This one... Better things is not to build the OMAP4 files for AM33XX only build.
Even if it is not trivial, its right way of fixing the issue.

Regards,
Santosh
