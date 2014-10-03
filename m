From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  3 Oct 2014 09:50:33 -0600
Subject: [PATCH V2 2/2] MAINTAINERS: condense some Tegra related entries
In-Reply-To: <1412351433-4003-1-git-send-email-swarren@wwwdotorg.org>
References: <1412351433-4003-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1412351433-4003-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

There's little point having specific entries in MAINTAINERS for Tegra
drivers that are already covered by the top-level Tegra architecture
support entry, and maintained by people listed there. Remove the
duplicates.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
v2: No change
---
 MAINTAINERS | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2210990fc3c6..22a8f753bb58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9015,11 +9015,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git
 S:	Supported
 N:	[^a-z]tegra
 
-TEGRA ASOC DRIVER
-M:	Stephen Warren <swarren@wwwdotorg.org>
-S:	Supported
-F:	sound/soc/tegra/
-
 TEGRA CLOCK DRIVER
 M:	Peter De Schrijver <pdeschrijver@nvidia.com>
 M:	Prashant Gaikwad <pgaikwad@nvidia.com>
@@ -9031,11 +9026,6 @@ M:	Laxman Dewangan <ldewangan@nvidia.com>
 S:	Supported
 F:	drivers/dma/tegra20-apb-dma.c
 
-TEGRA GPIO DRIVER
-M:	Stephen Warren <swarren@wwwdotorg.org>
-S:	Supported
-F:	drivers/gpio/gpio-tegra.c
-
 TEGRA I2C DRIVER
 M:	Laxman Dewangan <ldewangan@nvidia.com>
 S:	Supported
@@ -9052,11 +9042,6 @@ M:	Laxman Dewangan <ldewangan@nvidia.com>
 S:	Supported
 F:	drivers/input/keyboard/tegra-kbc.c
 
-TEGRA PINCTRL DRIVER
-M:	Stephen Warren <swarren@wwwdotorg.org>
-S:	Supported
-F:	drivers/pinctrl/pinctrl-tegra*
-
 TEGRA PWM DRIVER
 M:	Thierry Reding <thierry.reding@gmail.com>
 S:	Supported
-- 
1.9.1
