From: kiran.padwal@smartplayin.com (kiran.padwal at smartplayin.com)
Date: Fri, 12 Sep 2014 08:44:50 -0400 (EDT)
Subject: =?utf-8?Q?Re=3A_=5BPATCH=5D_iommu=3A_Make_of=5Fdevice=5Fid_array_const?=
In-Reply-To: <20140911135119.GH6158@arm.com>
References: <1410442656-21112-1-git-send-email-kiran.padwal@smartplayin.com>
 <20140911135119.GH6158@arm.com>
Message-ID: <1410525890.331211558@apps.rackspace.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday, September 11, 2014 9:51am, "Will Deacon" <will.deacon@arm.com> said:

> On Thu, Sep 11, 2014 at 02:37:36PM +0100, Kiran Padwal wrote:
>> Make of_device_id array const, because all OF functions handle it as const.
>>
>> Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
>> ---
>>  drivers/iommu/arm-smmu.c   |    2 +-
>>  drivers/iommu/omap-iommu.c |    2 +-
>>  drivers/iommu/tegra-gart.c |    2 +-
>>  drivers/iommu/tegra-smmu.c |    2 +-
>>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> Ha, I've seen a few of these patches recently. Did some tool just get
> support for detecting this?

No

> 
> Anyway, looks fine and should probably go via Joerg.
> 
> Will
> 
