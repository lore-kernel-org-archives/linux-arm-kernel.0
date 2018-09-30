From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 30 Sep 2018 20:07:13 +0200
Subject: [GIT PULL] arm: actions: arm64 for v4.20 #1
In-Reply-To: <20180930180715.25829-1-afaerber@suse.de>
References: <20180930180715.25829-1-afaerber@suse.de>
Message-ID: <20180930180715.25829-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,

Here's my arm64 pull for Actions Semi.

Regards,
Andreas

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-arm64-soc-for-4.20

for you to fetch changes up to e0c27a1066a935671a00b1764385bc8118d8022c:

  arm64: actions: Enable PINCTRL in platforms Kconfig (2018-09-30 19:11:33 +0200)

----------------------------------------------------------------
Actions Semi arm64 SoC for v4.20

This updates and extends the MAINTAINERS entry, adding Mani.
It also selects PINCTRL in Kconfig.

----------------------------------------------------------------
Manivannan Sadhasivam (6):
      MAINTAINERS: Add reviewer for ACTIONS platforms
      MAINTAINERS: Add Actions Semi S900 clk entries
      MAINTAINERS: Update clock binding entry for Actions Semi Owl SoCs
      MAINTAINERS: Add entry for Actions Semiconductor Owl I2C driver
      MAINTAINERS: Add entry for Actions Semi Owl SoCs DMA driver
      arm64: actions: Enable PINCTRL in platforms Kconfig

 MAINTAINERS                  | 7 +++++++
 arch/arm64/Kconfig.platforms | 1 +
 2 files changed, 8 insertions(+)
