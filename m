From: s-anna@ti.com (Suman Anna)
Date: Fri, 23 Jun 2017 16:29:26 -0500
Subject: [PATCH 0/4] Davinci remoteproc cleanups/fixes
In-Reply-To: <d2b8d230-33db-0615-f6cf-23b8446d8f50@ti.com>
References: <20170518220902.2846-1-s-anna@ti.com>
 <d2b8d230-33db-0615-f6cf-23b8446d8f50@ti.com>
Message-ID: <4b831afb-96be-03cc-d86b-77b423e95946@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2017 03:47 PM, Suman Anna wrote:
> Bjorn,
> 
> On 05/18/2017 05:08 PM, Suman Anna wrote:
>> Hi Bjorn,
>>
>> The following series includes various fixes and cleanups for the TI's
>> Davinci DSP remoteproc driver. Patches are based on 4.12-rc1. Following
>> is the patch summary:
>>
>>  - Patch1 updates/fixes the build dependency on DMA_CMA which is not
>>    selected by default in the davinci_defconfig.
>>  - Patch 3 fixes a DSP boot/functionality issue with repeated 'start'
>>    and 'stop' commands using the sysfs 'state' variable.
>>  - Patch 2 and 4 are cleanups/code simplifications.
> 
> If you don't have any comments, can you queue these patches for v4.13?

ping on this..

> 
> Thanks
> Suman
> 
>>
>> regards
>> Suman
>>
>> Suman Anna (4):
>>   remoteproc/davinci: Update Kconfig to depend on DMA_CMA
>>   remoteproc/davinci: simplify the reset function
>>   remoteproc/davinci: fix unbalanced reset between start and stop ops
>>   remoteproc/davinci: streamline the interrupt management
>>
>>  drivers/remoteproc/Kconfig            |  2 +-
>>  drivers/remoteproc/da8xx_remoteproc.c | 60 ++++++++---------------------------
>>  2 files changed, 15 insertions(+), 47 deletions(-)
>>
> 
