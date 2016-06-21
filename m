From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 21 Jun 2016 18:55:31 +0100
Subject: [GIT PULL] arm64: defconfig: juno updates for v4.8
Message-ID: <57697F93.4090904@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

Please pull !

-- 
Regards,
Sudeep

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git 
tags/juno-defconfig-4.8

for you to fetch changes up to 2a0e527c7ed60f9c85233bfe69a9023798c1d428:

   arm64: defconfig: enable SENSORS_ARM_SCPI (2016-06-20 16:45:30 +0100)

----------------------------------------------------------------
ARMv8 Juno/Vexpress defconfig updates for v4.8

1. Enable support for SCPI based sensors(temperature, voltage,
    current and power)

2. Enable the Generic on-chip SRAM driver. SRAM is used for SCPI based
    communication with SCP on Juno

----------------------------------------------------------------
Javi Merino (1):
       arm64: defconfig: enable SENSORS_ARM_SCPI

Sudeep Holla (1):
       arm64: defconfig: enable Generic on-chip SRAM driver

  arch/arm64/configs/defconfig | 2 ++
  1 file changed, 2 insertions(+)
