From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 30 Sep 2018 20:07:15 +0200
Subject: [GIT PULL] arm: actions: drivers for v4.20 #2
In-Reply-To: <20180930180715.25829-1-afaerber@suse.de>
References: <20180930180715.25829-1-afaerber@suse.de>
Message-ID: <20180930180715.25829-5-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,

Here's another drivers pull for Actions Semi.
It merges a topic branch with S900 SPS bindings.

Regards,
Andreas

The following changes since commit 067517513ae437c2845bc593dbf99a142bdc9250:

  soc: actions: Update SPS help text for S700 (2018-09-22 22:09:47 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git actions-drivers+s900-sps-for-4.20

for you to fetch changes up to da8c37e13d1dec58c795ca6ed81c3da064a3cbb4:

  soc: actions: sps: Add S900 power domains (2018-09-30 16:48:10 +0200)

----------------------------------------------------------------
Actions Semi SoC drivers for v4.20 #2

The SPS power domain driver is extended for S900 SoC.
This required merging a topic branch for the new bindings header.

----------------------------------------------------------------
Andreas F?rber (1):
      Merge branch 'v4.20/s900-sps-bindings' into v4.20/drivers+s900-sps

Manivannan Sadhasivam (2):
      dt-bindings: power: Add Actions Semi S900 SPS
      soc: actions: sps: Add S900 power domains

 .../devicetree/bindings/power/actions,owl-sps.txt  |  2 +
 drivers/soc/actions/Kconfig                        |  2 +-
 drivers/soc/actions/owl-sps.c                      | 58 ++++++++++++++++++++++
 include/dt-bindings/power/owl-s900-powergate.h     | 23 +++++++++
 4 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/power/owl-s900-powergate.h
