From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 13 Jul 2018 14:55:23 +0100
Subject: drivers: vexpress: update/cleanup for v4.19
Message-ID: <20180713135523.GB21499@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

Please pull !

Regards,
Sudeep

--

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/vexpress-update-4.19

for you to fetch changes up to cc4aecc5b724b47df65ef3e218ac7d73d2ee4e09:

  misc: vexpress/syscfg: Use devm_ioremap_resource() to map memory (2018-07-12 18:06:01 +0100)

----------------------------------------------------------------
ARMv7 Vexpress update/cleanup for v4.19

Just single cleanup patch to use devm_ioremap_resource in place of
devm_request_mem_region and devm_ioremap.

----------------------------------------------------------------
Sudeep Holla (1):
      misc: vexpress/syscfg: Use devm_ioremap_resource() to map memory

 drivers/misc/vexpress-syscfg.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)
