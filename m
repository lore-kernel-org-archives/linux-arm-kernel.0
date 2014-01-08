From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 8 Jan 2014 14:51:40 -0600
Subject: [GIT PULL] SOCFPGA DT updates for 3.14
Message-ID: <1389214300-5806-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof,

Please consider pulling in these 2 SOCFPGA DT patches for v3.14.

Thanks,
Dinh

The following changes since commit 374b105797c3d4f29c685f3be535c35f5689b30e:

  Linux 3.13-rc3 (2013-12-06 09:34:04 -0800)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-dt-for-3.14

for you to fetch changes up to 672ef909e9b10933dc676c87d1bdeaabfcc11dda:

  ARM: dts: socfpga: add pl330 clock (2014-01-08 12:04:03 -0600)

----------------------------------------------------------------
SOCFPGA DT updates for v3.14

----------------------------------------------------------------
Dinh Nguyen (1):
      ARM: dts: socfpga: update L2 tag and data latency

Steffen Trumtrar (1):
      ARM: dts: socfpga: add pl330 clock

 arch/arm/boot/dts/socfpga.dtsi |    4 ++++
 1 file changed, 4 insertions(+)
