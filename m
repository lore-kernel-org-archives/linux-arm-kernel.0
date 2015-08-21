From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Aug 2015 19:00:42 -0700
Subject: [GIT PULL 9/9] ARM: tegra: Default configuration updates for
 v4.3-rc1
In-Reply-To: <1439563720-13189-10-git-send-email-thierry.reding@gmail.com>
References: <1439563720-13189-1-git-send-email-thierry.reding@gmail.com>
 <1439563720-13189-10-git-send-email-thierry.reding@gmail.com>
Message-ID: <20150821020042.GN4865@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 04:48:40PM +0200, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> 
>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.3-defconfig
> 
> for you to fetch changes up to 258d9bc5e77fa40e290a0bd480d5349224374480:
> 
>   ARM: tegra: Update multi_v7_defconfig (2015-08-14 16:26:00 +0200)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> ARM: tegra: Default configuration updates for v4.3-rc1
> 
> Enable the GK20A GPU (via the Nouveau driver) and CPU frequency scaling
> on Tegra124.

I know there are issues surfaced by these changes, but the bug is unrelated to
the defconfig update per se.

I've chosen to merge this, with the hope that the root cause will be found and
fixed quickly. If needed, we can revert the options that are causing problems.


-Olof
