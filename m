From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 21 Sep 2018 16:07:22 +0100
Subject: [GIT PULL] arm64: defconfig: hisilicon config updates for v4.20
Message-ID: <5BA5092A.5070801@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

Please consider to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hisi-defconfig-for-4.20

for you to fetch changes up to 7265b3d9ddaae3dfbda9b1d1436809a6d1b5da7f:

  arm64: defconfig: Enable PCIEPORTBUS (2018-09-21 14:12:42 +0100)

----------------------------------------------------------------
ARM64: hisilicon: defconfig updates for 4.20

- Enable integrated NIC driver(hns3) for hisilicon SoCs
- Enable PCIe Port bus to support some PCIe features like
  AER, hotplug, PME and DPC

----------------------------------------------------------------
Dongdong Liu (1):
      arm64: defconfig: Enable PCIEPORTBUS

Zhou Wang (1):
      arm64: defconfig: enable HiSilicon HNS3 driver

 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)
