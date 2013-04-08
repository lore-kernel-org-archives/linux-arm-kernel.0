From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 8 Apr 2013 17:00:20 +0800
Subject: [GIT PULL 3/4] ARM: mxs: soc changes for 3.10
In-Reply-To: <1365411621-18422-1-git-send-email-shawn.guo@linaro.org>
References: <1365411621-18422-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1365411621-18422-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:

  Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-soc-3.10

for you to fetch changes up to 656c284c5c517460245db159e122b0207f06f998:

  ARM: mxs_defconfig: Select watchdog driver (2013-04-01 16:31:04 +0800)

----------------------------------------------------------------
The mxs soc changes for 3.10:

* A few mxs_defconfig changes
* Select ARM_CPU_SUSPEND for suspend testing

----------------------------------------------------------------
Fabio Estevam (4):
      ARM: mxs: Select ARM_CPU_SUSPEND
      ARM: mxs_defconfig: Build CONFIG_INPUT_EVDEV as built-in
      ARM: mxs_defconfig: Select CONFIG_MMC_UNSAFE_RESUME
      ARM: mxs_defconfig: Select watchdog driver

 arch/arm/configs/mxs_defconfig |    5 ++++-
 arch/arm/mach-mxs/Kconfig      |    2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)
