From: o.schinagl@ultimaker.com (Olliver Schinagl)
Date: Wed,  9 Sep 2015 15:26:43 +0200
Subject: [PATCH v2 0/1] Enable axp209 on OLinuXino lime2
Message-ID: <1441805204-6037-1-git-send-email-o.schinagl@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the new AXP209 node on the OLinuXino Lime2.
The previously submitted otg enablement patch is needed to avoid merge
conflicts.

Signed-off-by: Olliver Schinagl <o.schinagl@ultimaker.com>

Olliver Schinagl (1):
  ARM: dts: sun7i: Enable axp209 driver on olinuxino lime2

 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 87 +++++++++----------------
 1 file changed, 31 insertions(+), 56 deletions(-)

-- 
2.1.4
