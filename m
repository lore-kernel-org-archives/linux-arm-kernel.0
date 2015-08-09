From: oliver@schinagl.nl (Olliver Schinagl)
Date: Sun,  9 Aug 2015 20:22:57 +0200
Subject: [PATCH] ARM: dts: sunxi enable otg port on the
 sun7i-a20-olinuxino-lime2
Message-ID: <1439144578-7890-1-git-send-email-oliver@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olliver Schinagl <o.schinagl@ultimaker.com>

This patch enables the recently introduced OTG support for the OLinuXino Lime2.
Tested with a keyboard and some USB mass-storage flash-drives and various
hotplug.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>

Olliver Schinagl (1):
  ARM: dts: sunxi: enable otg port on the sun7i-a20-olinuxino-lime2

 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 41 +++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

-- 
2.1.4
