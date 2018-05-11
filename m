From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 11 May 2018 15:42:09 +0100
Subject: [GIT PULL] arm64: hisi: SoC driver updates for v4.18
Message-ID: <5AF5ABC1.60009@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof,

Please help to pull the following changes.
Sorry for the inconvenience, because it depends on this patch [1]
which was merged in the rc3, I rebased the pull on rc3.
Thanks!

[1] HISI LPC: Add Kconfig MFD_CORE dependency
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/bus?h=v4.17-rc3&id=4b313ca7b661ab8782f3dcb4a8996632a470b4da

Best Regards,
Wei

---

The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the Git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hisi-drivers-for-4.18

for you to fetch changes up to adf3457b4ce6940885be3e5ee832c6949fba4166:

  HISI LPC: Add ACPI UART support (2018-05-10 17:45:52 +0100)

----------------------------------------------------------------
ARM64: hisi: SoC driver updates for 4.18

- Update hisi LPC bus driver to use the platform driver APIs
  other than the MFD APIs to support connected device like UART

----------------------------------------------------------------
John Garry (3):
      HISI LPC: Stop using MFD APIs
      HISI LPC: Re-Add ACPI child enumeration support
      HISI LPC: Add ACPI UART support

 drivers/bus/Kconfig    |   1 -
 drivers/bus/hisi_lpc.c | 159 ++++++++++++++++++++++++++++++-------------------
 2 files changed, 97 insertions(+), 63 deletions(-)
