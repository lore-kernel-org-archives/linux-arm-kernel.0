From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 24 Aug 2017 11:16:16 +0100
Subject: [GIT PULL] firmware: arm_scpi: fix for v4.14
Message-ID: <0a748aa5-ff12-58ce-928d-940825da6d84@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC Team,

Please pull!

Regards,
Sudeep


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
tags/scpi-fixes-4.14

for you to fetch changes up to 0d30176819c8738b012ec623c7b3db19df818e70:

  firmware: arm_scpi: fix endianness of dev_id in struct dev_pstate_set
(2017-08-23 16:36:51 +0100)

----------------------------------------------------------------
ARM SCPI fixes for v4.14

Simple endianness fix for dev_id in dev_pstate_set structure

----------------------------------------------------------------
Sudeep Holla (1):
      firmware: arm_scpi: fix endianness of dev_id in struct dev_pstate_set

 drivers/firmware/arm_scpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
