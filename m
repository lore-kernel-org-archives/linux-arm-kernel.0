From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 17 Dec 2012 14:07:59 -0700
Subject: [PATCH 1/2] arm: tegra: Add new DT property to USB node.
In-Reply-To: <1355468348-8821-2-git-send-email-vbyravarasu@nvidia.com>
References: <1355468348-8821-1-git-send-email-vbyravarasu@nvidia.com>
 <1355468348-8821-2-git-send-email-vbyravarasu@nvidia.com>
Message-ID: <50CF89AF.3000308@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13/2012 11:59 PM, Venu Byravarasu wrote:
> As Tegra USB host driver is using instance number for resetting
> PORT0 twice, adding a new DT property for handling this.

Alan, Greg, Felip,e

This series looks fine to me.

I'd like to take all the Tegra-related USB patches through the Tegra
tree for 3.9 if possible (so I'm looking for your acks here). I believe
Venu plans to significantly clean up the EHCI/PHY driver split for
Tegra, rework the drivers, and add support for Tegra30 in addition to
Tegra20. Some of this requires changes to some Tegra board files and
device trees to maintain "git bisect" I don't know for sure yet, but I
believe that rework may also end up conflicting with other clock-related
rework that will show up for Tegra in 3.9. Are you OK with this? I'll
certainly look for your review/acks on the patches before picking them
up though.

Thanks.
