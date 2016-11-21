From: dinguyen@kernel.org (Dinh Nguyen)
Date: Mon, 21 Nov 2016 10:23:08 -0600
Subject: [GIT PULL 1/2] SoCFPGA DTS update for v4.10, part 3
Message-ID: <20161121162309.5408-1-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in this DTS update for v4.10.

Thanks,
Dinh

The following changes since commit d837a80d19505d74ee5941eebf9dd53fed6f36a6:

  ARM: dts: socfpga: add nand controller nodes (2016-11-09 12:40:52 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_dts_for_v4.10_part_3

for you to fetch changes up to 7c38dc624bc49d83d84c185e2ca14adf352c5eaa:

  ARM: dts: socfpga: fine-tune L2 cache configuration (2016-11-21 09:23:31 -0600)

----------------------------------------------------------------
SoCFPGA DTS update for v4.10, part 3
- Fine tune L2 cache configuration

----------------------------------------------------------------
Marek Vasut (1):
      ARM: dts: socfpga: fine-tune L2 cache configuration

 arch/arm/boot/dts/socfpga.dtsi | 5 +++++
 1 file changed, 5 insertions(+)
