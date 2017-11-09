From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu,  9 Nov 2017 09:29:48 +0100
Subject: [PATCH v2 0/2] Add dwmac-sun8i on A83T DT
Message-ID: <20171109082950.21124-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

This patch series add some device node for dwmac-sun8i on A83T.

Changes since v1:
- reworked commit log of patch #1
- added comment on drive strength

Corentin Labbe (2):
  ARM: sun8i: a83t: add dwmac-sun8i device node
  ARM: sun8i: bananapi-m3: Enable dwmac-sun8i

 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 18 +++++++++++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi            | 33 ++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

-- 
2.13.6
