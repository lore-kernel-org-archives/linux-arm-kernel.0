From: tj@kernel.org (Tejun Heo)
Date: Fri, 18 Jul 2014 17:54:04 -0400
Subject: [PATCH v5 1/8] of: Add NVIDIA Tegra SATA controller binding
In-Reply-To: <20140718150603.GA7196@ulmo>
References: <1405500863-19696-2-git-send-email-mperttunen@nvidia.com>
 <1405667500-7402-1-git-send-email-mperttunen@nvidia.com>
 <53C8C9BD.3070709@nvidia.com> <53C8F6E6.6020901@redhat.com>
 <20140718150603.GA7196@ulmo>
Message-ID: <20140718215404.GA1819@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 05:06:04PM +0200, Thierry Reding wrote:
> I think the following patches can go through your tree without causing
> breakage through unresolved dependencies:
> 
> 	[PATCH v5 1/8] of: Add NVIDIA Tegra SATA controller binding
> 	[PATCH v3 6/8] ata: ahci_platform: Increase AHCI_MAX_CLKS to 4
> 	[PATCH v5 7/8] ata: Add support for the Tegra124 SATA controller

Applied to libata/for-3.17 w/ Hans' acks added.  Please check the
following branch and give me a holler if something is amiss.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-3.17

Thanks.

-- 
tejun
