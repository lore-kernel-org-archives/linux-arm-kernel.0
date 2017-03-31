From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 31 Mar 2017 18:02:56 +0100
Subject: [GIT PULL] firmware: scpi: updates for v4.12
Message-ID: <bebdfb55-7704-716a-d00e-585be848af74@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC Team,

Please pull !

Regards,
Sudeep

---

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
tags/scpi-update-4.12

for you to fetch changes up to c511fa3f35e30982445fae2946f4aade3f42203d:

  firmware: arm_scpi: reinit completion instead of full
init_completion() (2017-03-31 11:00:23 +0100)

----------------------------------------------------------------
SCPI update for v4.12

Single patch to optimise the completion initialisation using reinit_*
API instead of full initialisation on each and every transfer.

----------------------------------------------------------------
Alexey Klimov (1):
      firmware: arm_scpi: reinit completion instead of full
init_completion()

 drivers/firmware/arm_scpi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
