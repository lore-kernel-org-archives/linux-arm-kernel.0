From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Tue, 26 Aug 2014 10:14:14 +0300
Subject: [PATCH v3 2/8] ARM: tegra: Add SATA controller to Tegra124 device
 tree
In-Reply-To: <53FB7111.2000602@wwwdotorg.org>
References: <1405500863-19696-1-git-send-email-mperttunen@nvidia.com>
 <1405500863-19696-3-git-send-email-mperttunen@nvidia.com>
 <53FB7111.2000602@wwwdotorg.org>
Message-ID: <53FC33C6.6010607@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/08/14 20:23, Stephen Warren wrote:
> On 07/16/2014 02:54 AM, Mikko Perttunen wrote:
>> This adds the integrated AHCI-compliant Serial ATA controller present
>> in Tegra124 systems-on-chip to the Tegra124 device tree.
>
> I have applied patches 2 and 3 to Tegra's for-3.18/dt branch. I fixed
> the DT node sort order when doing so.

Thanks :)

>
> I can't apply patch 8 (the defconfig change) until 3.17-rc2 is out, or
> there will be a build failure, but I will do so ASAP.
>
> BTW, once 3.17-rc2 is out, can you please sent a patch to
> multi_v7_defconfig enabling Tegra SATA support there too. Thanks.

Will do.

Cheers,
Mikko
