From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 11 Sep 2013 11:10:05 +0200
Subject: [PATCH 0/4] ARM: sun7i: Enable EMAC support for the A20
Message-ID: <1378890609-28563-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patch serie enables the EMAC IP found on the A20. Since it's basically the
same one than the one found in the A10 and A10s, it's basically just a matter
of adding the devices to the device tree.

Thanks,
Maxime

Maxime Ripard (4):
  ARM: sun7i: Enable the Ethernet in the A20
  ARM: sun7i: Add the muxing options for the EMAC
  ARM: sun7i: cubieboard2: Enable the EMAC
  ARM: sun7i: olinuxino-micro: Enable the EMAC

 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 15 ++++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 15 ++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                | 27 +++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

-- 
1.8.4
