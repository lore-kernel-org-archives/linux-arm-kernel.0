From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 21 May 2012 16:11:40 -0600
Subject: [PATCH] dt: name all Tegra binding docs consistently
Message-ID: <1337638300-29155-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Rename all Tegra binding documentation according to the first or
primary compatible value they describe. This provides a clear naming
scheme for the files, and prevents any naming conflicts should future
SoC versions require their own binding.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
I can take this through the Tegra tree if you want.

 .../arm/tegra/{emc.txt => nvidia,tegra20-emc.txt}  |    0
 .../{gpio_nvidia.txt => nvidia,tegra20-gpio.txt}   |    0
 .../{tegra-kbc.txt => nvidia,tegra20-kbc.txt}      |    0
 .../{nvidia-sdhci.txt => nvidia,tegra20-sdhci.txt} |    0
 .../nvec/{nvec_nvidia.txt => nvidia,nvec.txt}      |    0
 ...-alc5632.txt => nvidia,tegra-audio-alc5632.txt} |    0
 ...mslice.txt => nvidia,tegra-audio-trimslice.txt} |    0
 ...io-wm8753.txt => nvidia,tegra-audio-wm8753.txt} |    0
 ...io-wm8903.txt => nvidia,tegra-audio-wm8903.txt} |    0
 .../{tegra20-das.txt => nvidia,tegra20-das.txt}    |    0
 .../{tegra20-i2s.txt => nvidia,tegra20-i2s.txt}    |    0
 .../spi/{spi_nvidia.txt => nvidia,tegra20-spi.txt} |    0
 .../usb/{tegra-usb.txt => nvidia,tegra20-ehci.txt} |    0
 13 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/arm/tegra/{emc.txt => nvidia,tegra20-emc.txt} (100%)
 rename Documentation/devicetree/bindings/gpio/{gpio_nvidia.txt => nvidia,tegra20-gpio.txt} (100%)
 rename Documentation/devicetree/bindings/input/{tegra-kbc.txt => nvidia,tegra20-kbc.txt} (100%)
 rename Documentation/devicetree/bindings/mmc/{nvidia-sdhci.txt => nvidia,tegra20-sdhci.txt} (100%)
 rename Documentation/devicetree/bindings/nvec/{nvec_nvidia.txt => nvidia,nvec.txt} (100%)
 rename Documentation/devicetree/bindings/sound/{tegra-audio-alc5632.txt => nvidia,tegra-audio-alc5632.txt} (100%)
 rename Documentation/devicetree/bindings/sound/{tegra-audio-trimslice.txt => nvidia,tegra-audio-trimslice.txt} (100%)
 rename Documentation/devicetree/bindings/sound/{tegra-audio-wm8753.txt => nvidia,tegra-audio-wm8753.txt} (100%)
 rename Documentation/devicetree/bindings/sound/{tegra-audio-wm8903.txt => nvidia,tegra-audio-wm8903.txt} (100%)
 rename Documentation/devicetree/bindings/sound/{tegra20-das.txt => nvidia,tegra20-das.txt} (100%)
 rename Documentation/devicetree/bindings/sound/{tegra20-i2s.txt => nvidia,tegra20-i2s.txt} (100%)
 rename Documentation/devicetree/bindings/spi/{spi_nvidia.txt => nvidia,tegra20-spi.txt} (100%)
 rename Documentation/devicetree/bindings/usb/{tegra-usb.txt => nvidia,tegra20-ehci.txt} (100%)

diff --git a/Documentation/devicetree/bindings/arm/tegra/emc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/tegra/emc.txt
rename to Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
diff --git a/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt b/Documentation/devicetree/bindings/gpio/nvidia,tegra20-gpio.txt
similarity index 100%
rename from Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
rename to Documentation/devicetree/bindings/gpio/nvidia,tegra20-gpio.txt
diff --git a/Documentation/devicetree/bindings/input/tegra-kbc.txt b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
similarity index 100%
rename from Documentation/devicetree/bindings/input/tegra-kbc.txt
rename to Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
diff --git a/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
similarity index 100%
rename from Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt
rename to Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
diff --git a/Documentation/devicetree/bindings/nvec/nvec_nvidia.txt b/Documentation/devicetree/bindings/nvec/nvidia,nvec.txt
similarity index 100%
rename from Documentation/devicetree/bindings/nvec/nvec_nvidia.txt
rename to Documentation/devicetree/bindings/nvec/nvidia,nvec.txt
diff --git a/Documentation/devicetree/bindings/sound/tegra-audio-alc5632.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.txt
similarity index 100%
rename from Documentation/devicetree/bindings/sound/tegra-audio-alc5632.txt
rename to Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.txt
diff --git a/Documentation/devicetree/bindings/sound/tegra-audio-trimslice.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-trimslice.txt
similarity index 100%
rename from Documentation/devicetree/bindings/sound/tegra-audio-trimslice.txt
rename to Documentation/devicetree/bindings/sound/nvidia,tegra-audio-trimslice.txt
diff --git a/Documentation/devicetree/bindings/sound/tegra-audio-wm8753.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.txt
similarity index 100%
rename from Documentation/devicetree/bindings/sound/tegra-audio-wm8753.txt
rename to Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.txt
diff --git a/Documentation/devicetree/bindings/sound/tegra-audio-wm8903.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
similarity index 100%
rename from Documentation/devicetree/bindings/sound/tegra-audio-wm8903.txt
rename to Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
diff --git a/Documentation/devicetree/bindings/sound/tegra20-das.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra20-das.txt
similarity index 100%
rename from Documentation/devicetree/bindings/sound/tegra20-das.txt
rename to Documentation/devicetree/bindings/sound/nvidia,tegra20-das.txt
diff --git a/Documentation/devicetree/bindings/sound/tegra20-i2s.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt
similarity index 100%
rename from Documentation/devicetree/bindings/sound/tegra20-i2s.txt
rename to Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt
diff --git a/Documentation/devicetree/bindings/spi/spi_nvidia.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra20-spi.txt
similarity index 100%
rename from Documentation/devicetree/bindings/spi/spi_nvidia.txt
rename to Documentation/devicetree/bindings/spi/nvidia,tegra20-spi.txt
diff --git a/Documentation/devicetree/bindings/usb/tegra-usb.txt b/Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt
similarity index 100%
rename from Documentation/devicetree/bindings/usb/tegra-usb.txt
rename to Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt
-- 
1.7.0.4
