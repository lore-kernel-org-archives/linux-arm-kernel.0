From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 Oct 2013 14:02:24 -0600
Subject: [PATCH V2 1/6] ARM: tegra: add Tegra124 SoC support
In-Reply-To: <1381207808-14734-2-git-send-email-josephl@nvidia.com>
References: <1381207808-14734-1-git-send-email-josephl@nvidia.com>
 <1381207808-14734-2-git-send-email-josephl@nvidia.com>
Message-ID: <525464D0.9060009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2013 10:50 PM, Joseph Lo wrote:
> Add Tegra124 SoC support that base on CortexA15MP Core. And enable the
> SMP function that can re-use the same procedure with Tegra114.

I have applied patches 1, 2 to Tegra's for-3.13/soc branch, patches 3, 4
to Tegra's for-3.13/dt branch, not applied patch 5, and squashed patch 6
into Tegra's for-3.13/defconfig branch.
