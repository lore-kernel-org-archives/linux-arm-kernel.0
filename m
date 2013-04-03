From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 3 Apr 2013 09:22:13 +0530
Subject: [GIT PULL] ARM: OMAP5: hwmod, prm/cm data files and updates for
 3.10
In-Reply-To: <20130401170539.GK10155@atomide.com>
References: <1363768852-18125-1-git-send-email-santosh.shilimkar@ti.com>
 <20130401170539.GK10155@atomide.com>
Message-ID: <515BA76D.3000302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

On Monday 01 April 2013 10:35 PM, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130320 01:43]:
>> Tony,
>>
>> Here is the pull request for OMAP5 data file patches which are on list from
>> last merge window. As aligned on list, I have dropped clock data from the
>> series. That means for the boot, one clock data patch needs to be applied.
>> It is available on my git tree in 'out_of_tree/omap5_clk_data' branch.
>>
>> As discussed already on list, you will notice hwmod data loc has come down
>> from ~6000 lines to ~2000 lines becasue of removal of iospace, irq, dma data
>> as well as unused hwmods. Few hwmods for which dt conversion is pending are
>> not added as well but those would add max ~400 loc in future.
>>
>> The following changes since commit a937536b868b8369b98967929045f1df54234323:
>>
>>   Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git for_3.10/omap5_data_files
>>
>> for you to fetch changes up to 8a6a32e589a1a2a5a3fb8ebe8fc7426997bc6d89:
>>
>>   ARM: OMAP5: Enable build and frameowrk initialisations (2013-03-19 14:09:11 +0530)
> 
> Paul, do you have any comments on these?
> 
Ping.

> This branch should be queued separately because of the amount of
> LOC it adds. But as you may have other PRCM related patches then it's
> probably best that you queue it.
> 
Just to be clear, these are all data files patches which are auto-generated.

Thes patchset has already missed last couple of merge windows and its the
biggest bottleneck in getting OMAP5 booting from mainline. So I request
you to please have a look it quickly so that Tony can line that up for
3.10.

Thanks for help in advance !!

Regards,
Santosh
