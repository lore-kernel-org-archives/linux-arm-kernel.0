From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 16 Aug 2012 11:22:04 -0600
Subject: [PATCH V3 0/6] ARM: tegra: add CPU hotplug support
In-Reply-To: <1345109513-21553-1-git-send-email-josephl@nvidia.com>
References: <1345109513-21553-1-git-send-email-josephl@nvidia.com>
Message-ID: <502D2C3C.9090506@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/2012 03:31 AM, Joseph Lo wrote:
> This patch set adds CPU hotplug support for Tegra20 and Tegra30 SoCs.
> 
> The first 3 patches make the CPU clock and reset control be a module and
> the abstraction APIs for TegraXX SoCs. And clean up some codes for later
> usage. Then add CPU hotplug support for Tegra20 and Tegra30.
> 
> Verified on Seaboard(Tegra20) and Cardhu(Tegra30)

Thanks, I applied patches 1-5 to for-3.7/cpu-hotplug, and squashed patch
6 into the patch in for-3.7/defconfig.
