From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 17 Apr 2018 11:09:49 +0100
Subject: [GIT PULL] firmware: scmi: fixes for v4.17
Message-ID: <20180417100949.GB16146@e107533-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

Please pull !

Regards,
Sudeep

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  ssh://git at gitolite.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/scmi-fixes-4.17

for you to fetch changes up to d27a3c3436a7f68f3affd7991cb4a68e91dd747e:

  firmware: arm_scmi: remove redundant null check on array (2018-04-16 10:15:58 +0100)

----------------------------------------------------------------
SCMI fix for v4.17

A single patch eliminating the redundant null pointer check detected
by CoverityScan("Array compared against 0")

----------------------------------------------------------------
Colin Ian King (1):
      firmware: arm_scmi: remove redundant null check on array

 drivers/firmware/arm_scmi/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
