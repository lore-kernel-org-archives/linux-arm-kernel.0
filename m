From: dhdang@apm.com (Duc Dang)
Date: Wed, 30 Dec 2015 16:09:46 -0800
Subject: [GIT PULL] arm64: DTS fixes for X-Gene platforms for v4.5
Message-ID: <CADaLNDnwz-gyzN-1bzyGxAWL-5Jt2zSc_hvYQ2TpExGLC=Df3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Resend in plain text mode]

Hi Arnd, Olof,

This second pull request fixes the issue that you pointed out in my
first pull request for v4.5.

Please let me know if you want me to resend this when 4.5-rc1 is out instead.

Regards,
Duc Dang.
------

The following changes since commit 8000bc3fe99a304e244edfaf185b418b22e5579c:

  arm64: dts: Add L2 cache topology for APM X-Gene SoC (2015-11-17
13:11:56 -0800)

are available in the git repository at:

  https://github.com/AppliedMicro/xgene-next.git tags/xgene-dts-fixes-for-v4.5

for you to fetch changes up to 9ebf47bb748c17ebb2f9dde9169ed7a7612c3137:

  arm64: dts: X-Gene v2: I2C1 clock is always on (2015-12-29 17:05:31 -0800)

----------------------------------------------------------------
Fixes for X-Gene DTS for v4.5

This patch set fixes the node names of X-Gene I2C, GPIO
controller DT nodes; and also removes I2C clock nodes as
the same clock is shared between 2 I2C controllers
on X-Gene SoC.

----------------------------------------------------------------
Duc Dang (3):
      arm64: dts: Fix to use standard DT node names for X-Gene 1 and
X-Gene 2 platforms
      arm64: dts: X-Gene v1: I2C0 clock is always on
      arm64: dts: X-Gene v2: I2C1 clock is always on

 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 26 +++++++-------------------
 arch/arm64/boot/dts/apm/apm-storm.dtsi     | 24 +++++-------------------
 2 files changed, 12 insertions(+), 38 deletions(-)
