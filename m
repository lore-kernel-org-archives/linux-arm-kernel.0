From: dhdang@apm.com (Duc Dang)
Date: Mon, 30 Nov 2015 10:20:50 -0800
Subject: [GIT PULL] arm64: DTS changes for X-Gene platforms queued for v4.5
Message-ID: <CADaLNDnM463bnMq349q_2XEh2AeGs4yrp-y474wQZ-NCSE0Cqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Resend email in text format]

Hi Arnd and Olof,

Following is the first batch of dts changes for X-Gene platforms for
4.5. These are all the changes that missed 4.4 merge window.

Regards,
Duc Dang.
------

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://github.com/AppliedMicro/xgene-next.git tags/xgene-dts-for-v4.5-v1

for you to fetch changes up to 8000bc3fe99a304e244edfaf185b418b22e5579c:

  arm64: dts: Add L2 cache topology for APM X-Gene SoC (2015-11-17
13:11:56 -0800)

----------------------------------------------------------------
DTS changes for X-Gene platforms queued for v4.5

This patch set adds DTS entries to support various IPs
for X-Gene v1 and X-Gene v2 SoC:
- X-Gene v1: Enable support for MMC, USB, GPIO controllers,
  I2C controller, L2 Cache topology
- X-Gene v2: Enable support for MMC, USB, GPIO controller,
  I2C controller (with RTC), PCIe controller with GICv2m MSI,
  EDAC, L2 Cache topology, TRNG

----------------------------------------------------------------
Duc Dang (16):
      arm64: dts: Add the arasan mmc DTS entries for APm X-Gene v2 SoC
      arm64: dts: X-Gene: Do not reset or enable/disable clock for AHB block
      arm64: dts: Add RNG device tree nodes for APM X-Gene v2 platform
      arm64: dts: Add v2m MSI frame nodes for APM X-Gene v2 platforms
      arm64: dts: Add PCIe node for APM X-Gene v2 platforms
      arm64: dts: Add USB nodes for APM X-Gene v1 platforms
      arm64: dts: Add USB nodes for APM X-Gene v2 platforms
      arm64: dts: Add APM X-Gene v1 SoC GFC GPIO controller DTS entries
      arm64: dts: Add APM X-Gene v2 SoC GFC GPIO controller DTS entry
      arm64: dts: Add Designware GPIO dts binding for APM X-Gene v1 platform
      arm64: dts: Add APM X-Gene v2 SoC Designware GPIO controller DTS entry
      arm64: dts: Add APM X-Gene v2 SoC EDAC DTS entries
      arm64: dts: Add Designware I2C controller DTS entries for X-Gene v1 SoC
      arm64: dts: Add Designware I2C controller DTS entries for X-Gene
v2 SoC platform
      arm64: dts: Add RTC DTS entry for X-Gene v2 SoC platform
      arm64: dts: Add L2 cache topology for APM X-Gene SoC

Suman Tripathi (1):
      arm64: dts: Add the arasan mmc DTS entries for APM X-Gene v1 SoC

 arch/arm64/boot/dts/apm/apm-merlin.dts     |  12 +
 arch/arm64/boot/dts/apm/apm-mustang.dts    |   4 +
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 401 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apm/apm-storm.dtsi     | 126 +++++++++
 4 files changed, 543 insertions(+)
