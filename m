From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 17 Dec 2013 15:53:35 -0700
Subject: [PATCH 1/4] ARM: tegra: moving tegra_bct_strapping to tegra-soc.h
 for global visibility
In-Reply-To: <1387272400-4689-2-git-send-email-josephl@nvidia.com>
References: <1387272400-4689-1-git-send-email-josephl@nvidia.com>
 <1387272400-4689-2-git-send-email-josephl@nvidia.com>
Message-ID: <52B0D5EF.5090703@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2013 02:26 AM, Joseph Lo wrote:
> This patch moves the tegra_btc_strapping variable to the tegra-soc.h for
> the global visibility that the other Tegra device driver can access it.
> It also a preparation that we can move out the Tegra20 EMC driver from
> mach-tegra to the drivers folder.

Rather than introduce yet more dependencies between the Tegra tree and
other trees for 3.14, I'd like to see the two clock changes in this
series taken into the clock tree for 3.14, and the other 2 patches
deferred for 3.15.

Joseph, I assume that if patches 2/4 and 4/4 are applied without patches
1/4 and 3/4, there will be no issues?

This patch looks fine, I think ...
