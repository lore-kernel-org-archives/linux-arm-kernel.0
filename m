From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 28 Jun 2016 20:46:20 +0800
Subject: [GIT PULL 5/5] i.MX defconfig updates for 4.8
In-Reply-To: <1467117980-20063-1-git-send-email-shawnguo@kernel.org>
References: <1467117980-20063-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1467117980-20063-5-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.8

for you to fetch changes up to b57d82d7bafeda5d82d3426dc4ad8a50a82a867c:

  ARM: imx_v6_v7_defconfig: Select ADS7846 support (2016-06-28 09:59:28 +0800)

----------------------------------------------------------------
The i.MX defconfig update for 4.8:
 - Enable TOUCHSCREEN_ADS7846, USB_FUNCTIONFS and USB_USBNET support

----------------------------------------------------------------
Diego Dorta (1):
      ARM: imx_v6_v7_defconfig: Select ADS7846 support

Gary Bisson (1):
      ARM: imx_v6_v7_defconfig: enable USB FFS gadget

Peter Chen (1):
      ARM: imx_v6_v7_defconfig: build in usbnet to support NFS for non-ethernet board

 arch/arm/configs/imx_v6_v7_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
