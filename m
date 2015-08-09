From: oliver@schinagl.nl (Olliver Schinagl)
Date: Sun,  9 Aug 2015 21:02:47 +0200
Subject: [PATCH] ARM: dts: sunxi: Use the axp209 driver on the olimex lime2
Message-ID: <1439146968-9039-1-git-send-email-oliver@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables usage of the axp209 on the OLinuXino Lime2 and was tested
the OLinuXino Lime2-4GB.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>

Olliver Schinagl (1):
  ARM: dts: sunxi: enable otg port on the sun7i-a20-olinuxino-lime2

 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 131 ++++++++++++++----------
 1 file changed, 75 insertions(+), 56 deletions(-)

-- 
2.1.4
