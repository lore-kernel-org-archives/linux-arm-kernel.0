From: will.deacon@arm.com (Will Deacon)
Date: Tue, 7 Jul 2015 10:22:53 +0100
Subject: [PATCH v2 0/9] bugfixs and add support for non-pci devices
In-Reply-To: <1436239822-14132-1-git-send-email-thunder.leizhen@huawei.com>
References: <1436239822-14132-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <20150707092253.GB23879@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhen Lei,

On Tue, Jul 07, 2015 at 04:30:13AM +0100, Zhen Lei wrote:
> Changelog:
> v1 -> v2:
> update the implementation of patch 1/9 according to Will Deacon's suggestion.
> update the comment of patch 3/9 and 4/9.
> use arm_smmu_options to skip the execution of command CMD_PREFETCH_CONFIG, see patch 5/9.
> patch 6/9 is base on Laurent's series, to support probe deferral.
> patch 7/9 according to Robin Murphy's suggestion, remove global variable arm_smmu_devices, thanks.
> patch 9/9 add support for a master with multiple stream IDs.

FYI, I already picked some of your previous series on my iommu/devel branch:

  https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/log/?h=iommu/devel

I'll go over your v2 today, but I'm mainly interested in getting fixes
queued for 4.2 atm.

> Addition:
> scripts/checkpatch 6/9 reports a warning, this is temporary. I don't want
> patch 9/9 to display too many differences just because of add tabs.

That's fine. Whilst checkpatch can occassionally be a useful tool, it's
usually far too noisy imo.

Will
