From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 19 Dec 2017 08:02:14 +0100
Subject: [PATCH 0/3] irqchip: irq-bcm2836: add support for DT interrupt
 polarity
In-Reply-To: <1513024752-11246-1-git-send-email-stefan.wahren@i2se.com>
References: <1513024752-11246-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <d0c81267-8379-d4a1-ec56-fec3492c1df6@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Am 11.12.2017 um 21:39 schrieb Stefan Wahren:
> This patch series implements DT polarity support for the 1st level interrupt
> controller.
>
> Stefan Wahren (3):
>    dt-bindings: bcm2836-l1-intc: add interrupt polarity support
>    irqchip: irq-bcm2836: add support for DT interrupt polarity
>    ARM: dts: bcm283x: Define polarity of per-cpu interrupts
>
>   .../interrupt-controller/brcm,bcm2836-l1-intc.txt  |  4 +-
>   arch/arm/boot/dts/bcm2836.dtsi                     | 14 +++----
>   arch/arm/boot/dts/bcm2837.dtsi                     | 12 +++---
>   arch/arm/boot/dts/bcm283x.dtsi                     |  1 +
>   drivers/irqchip/irq-bcm2836.c                      | 46 +++++++++++++---------
>   5 files changed, 44 insertions(+), 33 deletions(-)
>

is this series okay?
