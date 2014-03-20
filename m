From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Mar 2014 14:41:13 -0700
Subject: [GIT PULL 4/5] ARM: tegra: device tree changes for 3.15
In-Reply-To: <1394224088-28910-4-git-send-email-swarren@wwwdotorg.org>
References: <1394224088-28910-1-git-send-email-swarren@wwwdotorg.org>
 <1394224088-28910-4-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140320214113.GD6649@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 07, 2014 at 01:28:07PM -0700, Stephen Warren wrote:
> This enables:
> * host1x and eDP support on Tegra124.
> * LCD panel support for a few Tegra20 devices and Venice2.
> * Enables power down, SPI flash, and USB on Venice2.
> * Documents which Dalmore revision is supported.
> * Adds an I2C bus mux to Cardhu.
> 
> Additionally, Tegra124 is converted to use #address-cells=<2> since the
> HW suports more than 32-bits of address space, and various cleanups are
> included.
> 
> ----------------------------------------------------------------
> 
> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> 
>   Linus 3.14-rc1
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.15-dt

Merged, thanks!


-Olof
