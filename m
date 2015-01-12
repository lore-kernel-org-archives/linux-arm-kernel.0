From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 12 Jan 2015 15:09:13 -0800
Subject: [GIT PULL] ARM: brcmstb: SMP updates for v3.20
Message-ID: <1421104153-6686-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  http://github.com/broadcom/stblinux tags/arm-soc/for-3.20/brcmstb-smp

for you to fetch changes up to a1ad3b94a7661b643fef2efbc6fc217bd148f462:

  ARM: brcmstb: update CPU power management sequence (2015-01-12 14:59:29 -0800)

----------------------------------------------------------------
This pull request contains updates to the brcmstb SMP code to use the manual
sequence instead of hardware state machine since it is not reliable.

----------------------------------------------------------------
Brian Norris (1):
      ARM: brcmstb: update CPU power management sequence

 arch/arm/mach-bcm/platsmp-brcmstb.c | 85 +++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 22 deletions(-)
