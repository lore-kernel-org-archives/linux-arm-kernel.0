From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 30 May 2015 17:36:51 +0200
Subject: [GIT PULL] ARM: mvebu: drivers changes for v4.2
In-Reply-To: <20150530141210.GE13641@io.lakedaemon.net>
References: <5568DF81.1090300@free-electrons.com>
 <20150530141210.GE13641@io.lakedaemon.net>
Message-ID: <5569D913.4030406@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On 30/05/2015 16:12, Jason Cooper wrote:
> Hey Gregory,
> 
> On Fri, May 29, 2015 at 11:52:01PM +0200, Gregory CLEMENT wrote:
>> Hi,
>>
>> Here is the first pull request for drivers for mvebu for v4.2.
>> It depends on the mvebu/fixes branch which have been merged in the
>> mvebu/drivers branch
>>
>> Gregory
>>
>> The following changes since commit 885dbd154b2f2ee305cec6fd0a162e1a77ae2b06:
>>
>>   Revert "bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window" (2015-05-28 11:14:31 +0200)
>>
>> are available in the git repository at:
>>
>>   git://git.infradead.org/linux-mvebu.git tags/mvebu-drivers-4.2
>>
>> for you to fetch changes up to bfa1ce5f38938cc9e6c7f2d1011f88eba2b9e2b2:
>>
>>   bus: mvebu-mbus: add mv_mbus_dram_info_nooverlap() (2015-05-28 12:21:08 +0200)
>>
>> ----------------------------------------------------------------
>> mvebu drivers change for 4.2
>>
>> mvebu-mbus: add mv_mbus_dram_info_nooverlap() needed for the new
>> Marvell crypto driver
>>
>> ----------------------------------------------------------------
>> Thomas Petazzoni (1):
>>       bus: mvebu-mbus: add mv_mbus_dram_info_nooverlap()
>>
>>  drivers/bus/mvebu-mbus.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/mbus.h     |   5 +++++
>>  2 files changed, 122 insertions(+)
>>
> 
> I don't see this in mvebu/for-next...  Not earth shattering, just mentioning
> it.  This commit is adding a new function with no callers, so the chances of
> conflicts / build failures is minimal.

Usually as soon as I apply a patch set, I also merge the branch in
mvebu/for-next and I push it on infradead. However it is still possible
that I forgot to push it. So I checked and this patch is part of mvebu/for-next:
http://git.infradead.org/linux-mvebu.git/commit/bfa1ce5f38938cc9e6c7f2d1011f88eba2b9e2b2

And it was even pulled in linux-next:
http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=bfa1ce5f38938cc9e6c7f2d1011f88eba2b9e2b2

So this time we are fine, but thanks for having a look on it.

Gregory

> 
> thx,
> 
> Jason.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
