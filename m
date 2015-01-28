From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 28 Jan 2015 16:49:39 -0700
Subject: [PATCH 24/24] Documentation: DT bindings: add nvidia,
 denver compatible string
In-Reply-To: <20150128234935.20644.89300.stgit@dusk.lan>
References: <20150128234935.20644.89300.stgit@dusk.lan>
Message-ID: <20150128234938.20644.69989.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Add a compatible string for the NVIDIA Denver CPU to the ARM CPU DT
binding documentation file.  The primary objective here is to keep
checkpatch.pl from warning when the compatible string is used in an
SoC DT file, per:

http://marc.info/?l=linux-tegra&m=142201349727836&w=2


Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Rohit Vaswani <rvaswani@codeaurora.org>
Cc: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Marc Carino <marc.ceeeee@gmail.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 Documentation/devicetree/bindings/arm/cpus.txt |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index b2aacbe16ed9..4ea31f0b7764 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -175,6 +175,7 @@ nodes to be present and contain the properties described below.
 			    "marvell,pj4a"
 			    "marvell,pj4b"
 			    "marvell,sheeva-v5"
+			    "nvidia,denver" (not yet matched in the code)
 			    "qcom,krait"
 			    "qcom,scorpion"
 	- enable-method
