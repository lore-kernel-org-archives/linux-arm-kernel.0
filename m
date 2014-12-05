From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 05 Dec 2014 17:46:25 +0100
Subject: [RFC 0/3] devfreq: exynos: Add driver for Exynos3250
Message-ID: <1417797988-29225-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The aim of patchset is to gather feedback about adding new devfreq driver for
Exynos 3250, along with the bindings.

Chanwoo,
You were the author of our initial exynos3_bus.c driver so do you
want me to add your Signed-off-by?

Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  devfreq: dt-bindings: Document Exynos3250 devfreq driver
  devfreq: exynos: Add driver for Exynos3250
  ARM: dts: Add devfreq to Exynos3250 and Rinato board

 .../bindings/arm/samsung/exynos3250-devfreq.txt    |  66 ++
 arch/arm/boot/dts/exynos3250-rinato.dts            |  10 +
 arch/arm/boot/dts/exynos3250.dtsi                  |  32 +
 drivers/devfreq/Kconfig                            |  12 +
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/exynos/Makefile                    |   1 +
 drivers/devfreq/exynos/exynos3_bus.c               | 842 +++++++++++++++++++++
 7 files changed, 964 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos3250-devfreq.txt
 create mode 100644 drivers/devfreq/exynos/exynos3_bus.c

-- 
1.9.1
