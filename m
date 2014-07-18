From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Jul 2014 16:48:14 +0200
Subject: [GIT PULL 5/7] ARM: create a cros-ec-keyboard DT fragment
In-Reply-To: <1405694740-4090-5-git-send-email-thierry.reding@gmail.com>
References: <1405694740-4090-1-git-send-email-thierry.reding@gmail.com>
 <1405694740-4090-5-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140718144813.GA7149@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 04:45:38PM +0200, Thierry Reding wrote:
> The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
> 
>   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.17-dt-cros-ec-kbd
> 
> for you to fetch changes up to 1a395e3b4f2e9038964c9eec392ed5300a4b5b83:
> 
>   ARM: dts: Use the cros-ec-keyboard fragment in exynos5250-snow (2014-06-16 12:11:32 -0600)
> 
> ----------------------------------------------------------------
> ARM: create a cros-ec-keyboard DT fragment
> 
> This branch contains a series from Doug Anderson that creates a DT
> include file to share some common DT content between Tegra and Exynos
> boards that use cros-ec. I'll be pulling this into Tegra's for-3.17/dt
> branch, and I assume the Samsung maintainers will do something similar.
> 
> ----------------------------------------------------------------
> Doug Anderson (3):
>       ARM: dts: Create a cros-ec-keyboard fragment
>       ARM: tegra: Use the cros-ec-keyboard fragment in venice2
>       ARM: dts: Use the cros-ec-keyboard fragment in exynos5250-snow
> 
>  arch/arm/boot/dts/cros-ec-keyboard.dtsi | 105 ++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5250-snow.dts   |  93 +---------------------------
>  arch/arm/boot/dts/tegra124-venice2.dts  |  96 +----------------------------
>  3 files changed, 111 insertions(+), 183 deletions(-)
>  create mode 100644 arch/arm/boot/dts/cros-ec-keyboard.dtsi

Note that Olof already mentioned that he had pulled this, but he also
said that he hadn't pulled it into anything that feeds into linux-next
so I thought I'd better send it again to make sure it's not forgotten.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140718/6dc736ea/attachment.sig>
