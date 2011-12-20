From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Dec 2011 18:07:38 -0800
Subject: [PATCH 1/3] arm/tegra: Delete tegra_init_clock()
In-Reply-To: <1324322645-30653-1-git-send-email-swarren@nvidia.com>
References: <1324322645-30653-1-git-send-email-swarren@nvidia.com>
Message-ID: <20111220020738.GH27789@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 12:24:03PM -0700, Stephen Warren wrote:
> tegra_init_clock() is written to call tegra2_init_clocks(), which only
> exists if Tegra20 support is enabled. This breaks the build of a
> Tegra30-only kernel.
> 
> tegra_init_clock() isn't actually used any more; tegra20_init_early()
> calls tegra2_init_clocks() directly. So, just delete this function.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> These 3 patches are all cleanup for Tegra's for-3.3/soc branch.

Thanks, applied 1-3 to for-3.3/soc.


-Olof
