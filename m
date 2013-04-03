From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 03 Apr 2013 15:10:37 -0600
Subject: [PATCH V6 0/9] ARM: tegra: add platform suspend support
In-Reply-To: <1364988712-24797-1-git-send-email-josephl@nvidia.com>
References: <1364988712-24797-1-git-send-email-josephl@nvidia.com>
Message-ID: <515C9ACD.3030002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 05:31 AM, Joseph Lo wrote:
> This series introduces a basic functionality for Tegra to support the
> platform suspend and resume.
> 
> Note: This series only adds the support for Tegra20 and Tegra30. The
> Tegra114 will be supported later.

The series is applied.

Patches 1-4 to Tegra's for-3.10/soc branch.
Patches 5-7, 9 to Tegra's for-3.10/dt branch.
Patch 8 squashed into Tegra's for-3.10/defconfig branch.
