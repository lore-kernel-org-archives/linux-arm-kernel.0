From: dhdang@apm.com (Duc Dang)
Date: Mon, 18 Apr 2016 16:24:23 -0700
Subject: [GIT PULL] arm64: X-Gene platforms DTS changes queued for 4.7 - part1
Message-ID: <CADaLNDmTBEGSMQKzK+tRNE=-qhRA7d3pqjRUTDRrp6_XStAkaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is the first part of DTS changes for X-Gene platforms queued for 4.7.

Regards,
Duc Dang.
------

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  https://github.com/AppliedMicro/xgene-next.git tags/xgene-dts-for-v4.7-part1

for you to fetch changes up to 01d1b6e543cfdc0f05027686b35d73de73caec10:

  arm64: dts: apm: Fix compatible string for X-Gene 2 SATA controller
DTS node (2016-04-14 17:34:22 -0700)

----------------------------------------------------------------
First part of X-Gene DTS changes queued for v4.7.

This patch set only includes a single change to
fix the compatible string for SATA controllers on
X-Gene v2 SOC platforms.

----------------------------------------------------------------
Rameshwar Prasad Sahu (1):
      arm64: dts: apm: Fix compatible string for X-Gene 2 SATA
controller DTS node

 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
