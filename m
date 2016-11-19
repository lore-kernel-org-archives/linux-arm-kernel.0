From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 18:37:25 -0800
Subject: [GIT PULL 8/10] ARM: tegra: Default configuration updates for
 v4.10-rc1
In-Reply-To: <20161118161719.24153-8-thierry.reding@gmail.com>
References: <20161118161719.24153-1-thierry.reding@gmail.com>
 <20161118161719.24153-8-thierry.reding@gmail.com>
Message-ID: <20161119023725.GS2543@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 05:17:17PM +0100, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.10-arm-defconfig
> 
> for you to fetch changes up to dafba3f6fb8614a114f939e5626447d71db864af:
> 
>   ARM: tegra: Enable GMI driver in default configuration (2016-11-08 11:49:41 +0100)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> ARM: tegra: Default configuration updates for v4.10-rc1
> 
> Enable audio support for various Toradex devices as well as the GMI.
> 
> ----------------------------------------------------------------
> Marcel Ziswiler (1):
>       ARM: tegra: Enable SGTL5000 audio
> 
> Thierry Reding (2):
>       ARM: tegra: Update default configuration for v4.9-rc1
>       ARM: tegra: Enable GMI driver in default configuration
> 
>  arch/arm/configs/tegra_defconfig | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> --

Merged, thanks.


-Olof
