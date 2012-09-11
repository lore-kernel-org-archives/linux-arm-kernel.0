From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Sep 2012 11:10:59 -0600
Subject: [PATCH 1/2] ARM: tegra: remove dead code
In-Reply-To: <1346137800-7448-1-git-send-email-swarren@wwwdotorg.org>
References: <1346137800-7448-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <504F70A3.6070609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/2012 01:09 AM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Now that all boards are converted to device tree, devices.[ch] and
> board-pinmux.[ch] are no longer used. So, remove them.
> 
> The only exception is the EHCI platform data in devices.h. Move that
> data to board-dt-tegra20.c - the only places it's used.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied this 1 patch to Tegra's for-3.7/cleanup2 branch.

Note that the crash Laxman reported against this series was due to patch
2/2, which has since been revised and applied. Patch 1/1 didn't have issues.
