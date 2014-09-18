From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 19 Sep 2014 02:03:20 +0800
Subject: [GIT PULL v2] [for v3.17] pull request from pxa to fix ssp name
Message-ID: <CAD6h2NRZ1GM_dYm+OgZHiUAMWE2dzq_jvQe3YM=HdY7ibPdudg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd, Kevin,

Please help to merge the pull request from pxa git repository.

Best Regards
Haojian

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git
tags/pxa3xx-ssp-name

for you to fetch changes up to 0da0e227477fdf7c7712ab973621630ba88aebcb:

  ARM: pxa3xx: provide specific platform_devices for all ssp ports
(2014-09-19 01:58:43 +0800)

----------------------------------------------------------------
fix PXA3xx SSP naming issue. It's imported by 972a55b62 ASoC: fix
pxa-ssp compiling issue under mach-mmp from v3.5

----------------------------------------------------------------
Daniel Mack (2):
      ARM: pxa: ssp: provide platform_device_id for PXA3xx
      ARM: pxa3xx: provide specific platform_devices for all ssp ports

 arch/arm/mach-pxa/devices.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 arch/arm/mach-pxa/devices.h |  3 +++
 arch/arm/mach-pxa/pxa3xx.c  | 14 +++++++-------
 arch/arm/plat-pxa/ssp.c     |  1 +
 4 files changed, 51 insertions(+), 9 deletions(-)
