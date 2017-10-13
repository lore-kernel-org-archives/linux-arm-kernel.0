From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 13 Oct 2017 10:40:46 +0100
Subject: [GIT PULL] arm64: defconfig: hisilicon config updates for v4.15
Message-ID: <59E08A1E.9070508@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin,

Please help to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hisi-defconfig-for-4.15

for you to fetch changes up to f9a3da591d4bf5ad28eb9ffabc823dee9e4254f4:

  arm64: defconfig: Enable hisilicon hibmc drm driver (2017-10-10 15:17:41 +0100)

----------------------------------------------------------------
ARM64: hisilicon: defconfig updates for 4.15

- Enable DRM_HISI_HIBMC for the D03/D05 board

----------------------------------------------------------------
Kefeng Wang (1):
      arm64: defconfig: Enable hisilicon hibmc drm driver

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)
