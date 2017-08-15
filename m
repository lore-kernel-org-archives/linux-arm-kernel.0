From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 15 Aug 2017 14:24:30 +0100
Subject: [GIT PULL] arm64: defconfig: hisilicon config updates for v4.14
Message-ID: <5992F60E.2060403@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin,

Please help to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hisi-defconfig-for-4.14

for you to fetch changes up to 4bd68d6038ffdcf5792fb7705bfd84caaaf39b2e:

  arm64: defconfig: enable DMA driver for hi3660 (2017-08-14 16:14:16 +0100)

----------------------------------------------------------------
ARM64: hisilicon: defconfig updates for 4.14

- Enable Kirin PCIe host, hi6421v530 mfd and regulator,
  syscon reboot mode, serdev bus, OP-TEE and K3 DMA support
  for hikey and hikey960

- Enable pcie based sas controller support for hip08 SoC

----------------------------------------------------------------
Guodong Xu (3):
      arm64: defconfig: enable support hi6421v530 PMIC
      arm64: defconfig: enable CONFIG_SYSCON_REBOOT_MODE
      arm64: defconfig: enable support for serial port connected device

John Garry (1):
      arm64: defconfig: enable SCSI_HISI_SAS_PCI

Victor Chong (1):
      arm64: defconfig: enable OP-TEE

Wang Ruyi (1):
      arm64: defconfig: enable DMA driver for hi3660

Xiaowei Song (1):
      arm64: defconfig: enable Kirin PCIe

 arch/arm64/configs/defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)
