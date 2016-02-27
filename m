From: xuwei5@hisilicon.com (Wei Xu)
Date: Sat, 27 Feb 2016 17:44:12 +0800
Subject: [GIT PULL]Hisilicon Hip05 SoC DT updates for 4.6
Message-ID: <56D16FEC.9070906@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin,

Please help to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hip05-dt-for-4.6

for you to fetch changes up to 82a14b1e95b4ce003bf8774861f631ea47e54975:

  arm64: dts: hip05: Append power button node for D02 board (2016-02-25 21:15:58 +0800)

----------------------------------------------------------------
ARM64: DT: Hisilicon Hip05 soc and D02 board updates for 4.6

- Add L2 cache topology
- Use Cortex specific device node for pmu
- Append all gicv3 ITS entries
- Append gpio nodes
- Append power button node for D02 board

----------------------------------------------------------------
Kefeng Wang (5):
      arm64: dts: hip05: Add L2 cache topology
      arm64: dts: hip05: Use Cortex specific device node for pmu
      arm64: dts: hip05: Append all gicv3 ITS entries
      arm64: dts: hip05: Append gpio nodes
      arm64: dts: hip05: Append power button node for D02 board

 arch/arm64/boot/dts/hisilicon/hip05-d02.dts | 18 ++++++
 arch/arm64/boot/dts/hisilicon/hip05.dtsi    | 92 ++++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 2 deletions(-)
