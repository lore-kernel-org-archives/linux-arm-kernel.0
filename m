From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Mon, 12 May 2014 12:15:18 +0530
Subject: [PATCH 0/2] ARM: dts: enable display for exynos5800 based peach-pi
 board
Message-ID: <1399877120-4634-1-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

Add nodes for fimd and dp controller for exynos5800 based
peach-pi board.

This series is based on Kukjin Kims, for-next branch.

It is dependent on
1) Arun's patches for basic Exynos5800 support, available at
http://comments.gmane.org/gmane.linux.kernel.samsung-soc/30667

Rahul Sharma (2):
  ARM: dts: enable display controller for exynos5800 based peach-pi
    board
  ARM: dts: enable fimd for exynos5800 based peach-pi board

 arch/arm/boot/dts/exynos5800-peach-pi.dts |   41 +++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

-- 
1.7.9.5
