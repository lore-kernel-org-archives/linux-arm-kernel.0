From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 11 May 2018 14:29:42 +0100
Subject: [GIT PULL] firmware: scmi: fixes for v4.17 (part 2)
Message-ID: <20180511132942.GA18590@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

Please pull !

Regards,
Sudeep

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/scmi-fixes-4.17

for you to fetch changes up to 31c6085562a03124d3f6a5c43dd9888ac44495a5:

  firmware: arm_scmi: Use after free in scmi_create_protocol_device() (2018-05-08 18:03:47 +0100)

----------------------------------------------------------------
SCMI fix for v4.17

A single patch to ensure that the scmi device is not used for setting up
scmi handle after it's freed(fixes use after free).

----------------------------------------------------------------
Dan Carpenter (1):
      firmware: arm_scmi: Use after free in scmi_create_protocol_device()

 drivers/firmware/arm_scmi/driver.c | 1 +
 1 file changed, 1 insertion(+)
