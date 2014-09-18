From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 18 Sep 2014 20:15:21 +0300
Subject: [PATCH 0/3] ARM: dts: keystone: fix and updates
Message-ID: <1411060524-25077-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

This serie contains fix of SPI nodes DT defintions for Keystone K2L  SoC.

Also It adds DT definitions for Keystone 2 DSP GPIO and IRQ controllers.


Grygorii Strashko (2):
  ARM: dts: keystone: add keystone irq controller node
  ARM: dts: keystone: add dsp gpio controllers nodes

Murali Karicheri (1):
  ARM: dts: keystone: k2l: Fix chip selects for SPI devices

 arch/arm/boot/dts/k2e.dtsi      |  7 ++++++
 arch/arm/boot/dts/k2hk.dtsi     | 56 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/k2l.dtsi      | 42 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/keystone.dtsi |  8 ++++++
 4 files changed, 113 insertions(+)

-- 
1.9.1
