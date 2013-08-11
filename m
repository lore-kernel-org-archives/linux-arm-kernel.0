From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 11 Aug 2013 18:31:57 +0800
Subject: [GIT PULL] pxa dt binding for v3.12
Message-ID: <CAN1soZx5Ax1jq3psJXwnHozBP6jA9Y3ziRL=go=bP5k2ds=thg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof & Arnd,

Here's the pull request from pxa git tree.

Regards
Haojian

The following changes since commit c095ba7224d8edc71dcef0d655911399a8bd4a3f:

  Linux 3.11-rc4 (2013-08-04 13:46:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git tags/pxa-dt

for you to fetch changes up to 781c8603856c9e8b37f1348cdb9a5685910a7225:

  ARM: pxa: DTS: override gpio node in pxa3xx.dtsi (2013-08-11 17:50:27 +0800)

----------------------------------------------------------------
dt binding for gpio-pxa

----------------------------------------------------------------
Daniel Mack (2):
      ARM: pxa: fix DT auxdata for pxa3xx-gpio
      ARM: pxa: DTS: override gpio node in pxa3xx.dtsi

 arch/arm/boot/dts/pxa3xx.dtsi | 11 +++++++++++
 arch/arm/mach-pxa/pxa-dt.c    |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)
