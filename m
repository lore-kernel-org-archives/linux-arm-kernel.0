From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 19 Jul 2013 10:54:31 -0600
Subject: [PATCH V2 00/11] ARM: tegra114: add support for system suspend
In-Reply-To: <1372845047-25147-1-git-send-email-josephl@nvidia.com>
References: <1372845047-25147-1-git-send-email-josephl@nvidia.com>
Message-ID: <51E96F47.5080206@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/2013 03:50 AM, Joseph Lo wrote:
> This series introduce system suspend function for Tegra114 and depend on
> the series of "ARM: tegra114: cpuidle: add power down state".
> 
> Verified on Seaboard, Cardhu and Dalmore and with THUMB2_KERNEL as well.

Patches 1-9 applied to Tegra's for-3.12/soc branch. Patch 10 dropped
since Laxman's patch was more complete. Patch 11 applied to Tegra's
for-3.12/dt branch.
