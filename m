From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 18 Nov 2014 09:41:33 +0800
Subject: [GIT PULL RESEND]Hisilicon HiX5HD2 soc defconfig updates for v3.19
Message-ID: <546AA3CD.2000907@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Could you please help to merge pull request for hisilicon hix5hd2 soc config updates for 3.19?
I have tested it and it is OK.
Thanks!

Best Regards,
Wei

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hix5hd2-config-for-3.19

for you to fetch changes up to c56a3fbb811d51a810f97a1aca00d37840509b68:

  ARM: hisi_defconfig: add driver support for hix5hd2 (2014-11-07 19:59:58 +0800)

----------------------------------------------------------------
ARM: HiX5HD2: config update for 3.19

- Enable GMAC, GPIO, Reset, USB, MMC and SATA on HiX5HD2

----------------------------------------------------------------
Zhangfei Gao (1):
      ARM: hisi_defconfig: add driver support for hix5hd2

 arch/arm/configs/hisi_defconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
