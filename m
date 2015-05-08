From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 8 May 2015 15:34:06 +0100
Subject: [GIT PULL]Hisilicon hip04 soc defconfig updates for v4.2
Message-ID: <554CC95E.2060701@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin,

Please help to merge pull request for hisilicon hip04 soc defconfig updates for v4.2.

Later I will send another patch to update multi_v7_defconfig about it.
Thanks!

Best Regards,
Wei

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hip04-config-for-4.2

for you to fetch changes up to ecda6547d7e4410c00168abae56d6fa4271d0a7e:

  ARM: defconfig: hisi: enable HiSilicon hip04 ethernet controller (2015-05-08 23:50:54 +0100)

----------------------------------------------------------------
ARM: HIP04: configure updates for 4.2

- Enable ethernet on hip04 SoC
- Enable Sysnopsis GPIO controller on hip04 SoC

----------------------------------------------------------------
Fathi Boudra (1):
      ARM: defconfig: hisi: enable HiSilicon hip04 ethernet controller

Zhou Wang (1):
      ARM: hip04: add GPIO configure in hisi_defconfig

 arch/arm/configs/hisi_defconfig | 2 ++
 1 file changed, 2 insertions(+)
