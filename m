From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 13 Mar 2012 22:54:24 +0530
Subject: [PATCH v2 0/2] Fixes in hwmod reset code
In-Reply-To: <alpine.DEB.2.00.1203130819480.22211@utopia.booyaka.com>
References: <1331647435-31666-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1203130819480.22211@utopia.booyaka.com>
Message-ID: <4F5F82C8.7000002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Tuesday 13 March 2012 07:52 PM, Paul Walmsley wrote:
> Hi Rajendra
>
> On Tue, 13 Mar 2012, Rajendra Nayak wrote:
>
>> This fixes a couple of issues around hwmod reset
>> APIs'.
>> Patches are based on 3.3.-rc7.
>>
>> Rajendra Nayak (2):
>>    ARM: omap: hwmod: Restore sysc after a reset
>>    ARM: omap: hwmod: Make omap_hwmod_softreset wait for reset status
>>
>>   arch/arm/mach-omap2/omap_hwmod.c |   18 ++++++------------
>>   1 files changed, 6 insertions(+), 12 deletions(-)
>
> Could you base this on either my 'hwmod_code_cleanup_3.4' branch or
> 'hwmod_enable_remaining_hwmods_devel_3.4' branch?  There are some reset
> changes in there also.

Sure, will send them out shortly.

regards,
Rajendra
>
>
> - Paul
