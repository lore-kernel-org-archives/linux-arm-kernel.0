From: olof@lixom.net (Olof Johansson)
Date: Sat, 19 Jul 2014 12:44:16 -0700
Subject: [GIT PULL 3/7] ARM: tegra: rework PCIe regulators
In-Reply-To: <1405694740-4090-3-git-send-email-thierry.reding@gmail.com>
References: <1405694740-4090-1-git-send-email-thierry.reding@gmail.com>
 <1405694740-4090-3-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140719194416.GC10514@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 04:45:36PM +0200, Thierry Reding wrote:
> The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
> 
>   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.17-pcie-regulators
> 
> for you to fetch changes up to 122ee17dc2adb5c4a63d3a29af9f4e6e331087e5:
> 
>   ARM: tegra: Remove legacy PCIe power supply properties (2014-07-18 11:20:10 +0200)
> 
> ----------------------------------------------------------------
> ARM: tegra: rework PCIe regulators
> 
> This branch reworks the set of regulators that the Tegra PCIe driver
> uses, so that the driver and DT bindings more correctly model what's
> really going on in HW. For backwards-compatibility the driver will
> fallback to using the old set of regulators if the new ones can't be
> found.
> 
> I've made this a separate branch in case it needs to be pulled into the
> PCIe tree to resolve any conflicts.

Merged into next/drivers. Again, thanks for respinning and making it handle the
old bindings too. I'm glad it wasn't too hard to sort out.


-Olof
