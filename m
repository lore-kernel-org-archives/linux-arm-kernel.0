From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Dec 2011 18:05:02 -0800
Subject: [PATCH 0/2] arm/tegra: Fix section mismatch errors in pinmux
In-Reply-To: <1324317718-24464-1-git-send-email-swarren@nvidia.com>
References: <1324317718-24464-1-git-send-email-swarren@nvidia.com>
Message-ID: <20111220020502.GG27789@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 11:01:56AM -0700, Stephen Warren wrote:
> Patches in Tegra's for-3.3/soc branch introduce some section mismatch
> errors when building with CONFIG_DEBUG_SECTION_MISMATCH=y. This series
> fixes them. I patched each file separately in case you want to squash
> these into the original patches.
> 
> tegra20: 6996e08 arm/tegra: prepare pinmux code for multiple tegra variants
> tegra30: 241682c arm/tegra: pinmux tables and definitions for tegra30

Thanks, applied to for-3.3/soc.


-Olof
