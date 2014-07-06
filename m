From: olof@lixom.net (Olof Johansson)
Date: Sun, 6 Jul 2014 16:46:43 -0700
Subject: [GIT PULL] ARM: create a cros-ec-keyboard DT fragment
In-Reply-To: <1402949751-930-1-git-send-email-swarren@wwwdotorg.org>
References: <1402949751-930-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140706234643.GC5539@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 02:15:51PM -0600, Stephen Warren wrote:
> This branch contains a series from Doug Anderson that creates a DT
> include file to share some common DT content between Tegra and Exynos
> boards that use cros-ec. I'll be pulling this into Tegra's for-3.17/dt
> branch, and I assume the Samsung maintainers will do something similar.
> 
> ----------------------------------------------------------------
> 
> The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
> 
>   Linux 3.16-rc1
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.17-dt-cros-ec-kbd

Thanks. I've pulled this in as a branch in arm-soc.git, but not into something
that feeds for-next since the contents will come through your trees anyway.


-Olof
