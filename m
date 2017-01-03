From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 3 Jan 2017 18:50:52 +0000
Subject: [GIT PULL] drivers: firmware: PSCI fixes for v4.10
Message-ID: <20170103185052.GA23238@e107981-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC,

please consider pulling these minor PSCI fixes for v4.10.

Thank you very much.

Regards,
Lorenzo

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git tags/psci-fixes-4.10

for you to fetch changes up to 32d53d1baf874caabe66ba565699ed5853fa2b6f:

  MAINTAINERS: extend PSCI entry to cover the newly add PSCI checker code (2017-01-03 17:53:00 +0000)

----------------------------------------------------------------
PSCI fixes for v4.10

Two minor fixes following the merge of the PSCI checker:

- Annotate the PSCI checker timer on the stack used to wake-up from
  suspend to prevent warnings when the DEBUG_OBJECTS config option
  is enabled
- Extend the PSCI entry in the maintainers list to also include the
  PSCI checker code

----------------------------------------------------------------
Sudeep Holla (2):
      drivers: psci: annotate timer on stack to silence odebug messages
      MAINTAINERS: extend PSCI entry to cover the newly add PSCI checker code

 MAINTAINERS                     | 2 +-
 drivers/firmware/psci_checker.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
