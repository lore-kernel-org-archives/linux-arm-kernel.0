From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Sep 2012 11:11:35 -0600
Subject: [PATCH V2] ARM: tegra: remove useless includes of <mach/*.h>
In-Reply-To: <1347381756-28714-1-git-send-email-swarren@wwwdotorg.org>
References: <1347381756-28714-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <504F70C7.80502@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2012 10:42 AM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Nothing from these files is needed, so remove the includes. This helps
> single zImage work by reducing use of the mach-tegra/include/mach/
> directory.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied to Tegra's for-3.7/cleanup2 branch.
