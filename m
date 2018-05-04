From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 4 May 2018 09:45:31 +0000
Subject: [PATCH v2 0/2] ARM64: dts: meson-axg: enable wifi driver
Message-ID: <20180504094533.15588-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 These patches try to enable the WIFI module AP6255 in Meson-AXG S400
baord. First patch revert an error which was introduced in early commit.

Hi Kevin
 Please squash patch 1 into the commit[1] of your v4.18/dt64 branch,
which was the error introduced there.

Change since v1 at [2]:
  - fix wrong reset gpio pin

 [1] 7e1eee2ec496 'ARM64: dts: meson-axg: enable the eMMC controller'
 [2] https://lkml.kernel.org/r/20180423145729.14368-1-yixun.lan at amlogic.com

Yixun Lan (2):
  ARM64: dts: meson-axg: drop sdio pwrseq property
  ARM64: dts: meson-axg: enable AP6255 wifi module

 .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 44 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

-- 
2.17.0
