From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 21:10:08 -0800
Subject: [GIT PULL 5/5] i.MX defconfig updates for 4.11
In-Reply-To: <1485662803-31235-5-git-send-email-shawnguo@kernel.org>
References: <1485662803-31235-1-git-send-email-shawnguo@kernel.org>
 <1485662803-31235-5-git-send-email-shawnguo@kernel.org>
Message-ID: <20170130051008.GT18943@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2017 at 12:06:43PM +0800, Shawn Guo wrote:
> The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:
> 
>   Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.11
> 
> for you to fetch changes up to 5aaac4278afa6ef8a42dc2c51f3e1a1a20d5bd97:
> 
>   ARM: vf610m4: defconfig: enable EXT4 filesystem (2017-01-24 21:50:14 +0800)
> 
> ----------------------------------------------------------------
> i.MX defconfig updates for 4.11:
>  - Select wireless extensions option for imx_v6_v7_defconfig, so that
>    wireless works out of box with userspace tools such as 'iwconfig'.
>  - Enable EXT4 filesystem support for vf610m4_defconfig.
> 
> ----------------------------------------------------------------
> Fabio Estevam (1):
>       ARM: imx_v6_v7_defconfig: Select wireless extensions option
> 
> afzal mohammed (1):
>       ARM: vf610m4: defconfig: enable EXT4 filesystem
> 
>  arch/arm/configs/imx_v6_v7_defconfig | 4 ++--
>  arch/arm/configs/vf610m4_defconfig   | 3 +--
>  2 files changed, 3 insertions(+), 4 deletions(-)

Merged, thanks


-Olof
