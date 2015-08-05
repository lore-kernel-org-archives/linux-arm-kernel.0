From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed,  5 Aug 2015 10:44:43 -0700
Subject: [GIT PULL] Broadcom SoC changes for 4.3 (part 2)
In-Reply-To: <1438796683-18581-1-git-send-email-f.fainelli@gmail.com>
References: <1438796683-18581-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1438796683-18581-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 39aa437e18cac7acae55481ed73feea0de497399:

  Merge branch 'queue/irq/arm' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip into next/cleanup (2015-08-05 17:24:11 +0200)

are available in the git repository at:

  http://github.com/broadcom/stblinux tags/arm-soc/for-4.3/soc-part2

for you to fetch changes up to 661e59d30168331e5e1c7386d23ea8fd14965270:

  ARM: BCM: Enable ARM erratum 798181 for BRCMSTB (2015-08-05 10:30:59 -0700)

----------------------------------------------------------------
This pull request contains the following changes:

- Gregory updates the BRCMSTB Kconfig to select the ARM erratum 798181 which
  affects the chips covered by this platform

----------------------------------------------------------------
Gregory Fong (1):
      ARM: BCM: Enable ARM erratum 798181 for BRCMSTB

 arch/arm/mach-bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)
