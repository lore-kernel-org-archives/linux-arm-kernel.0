From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat,  8 Aug 2015 12:50:44 -0700
Subject: [GIT PULL] Broadcom SoC changes for 4.3 (part 2, try2)
In-Reply-To: <55C4E8C8.7030503@broadcom.com>
References: <55C4E8C8.7030503@broadcom.com>
Message-ID: <1439063444-12466-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 39aa437e18cac7acae55481ed73feea0de497399:

  Merge branch 'queue/irq/arm' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip into next/cleanup (2015-08-05 17:24:11 +0200)

are available in the git repository at:

  http://github.com/broadcom/stblinux tags/arm-soc/for-4.3/soc-part2

for you to fetch changes up to cf1140515b3b94ef5aa06a085e94ddd814a8cd78:

  ARM: brcmstb: select ARCH_DMA_ADDR_T_64BIT for LPAE (2015-08-06 21:38:13 -0700)

----------------------------------------------------------------
This pull request contains two changes for brcmstb SoCs from Gregory:

- Update the BRCMSTB Kconfig to select the ARM erratum 798181 which
  affects the chips covered by this platform

- Update the BRCMST Kconfig to select 64-bits DMA address types when LPAE
  is enabled

----------------------------------------------------------------
Gregory Fong (2):
      ARM: BCM: Enable ARM erratum 798181 for BRCMSTB
      ARM: brcmstb: select ARCH_DMA_ADDR_T_64BIT for LPAE

 arch/arm/mach-bcm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)
