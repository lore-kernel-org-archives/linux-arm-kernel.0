From: fathi.boudra@linaro.org (Fathi Boudra)
Date: Fri, 10 Apr 2015 10:16:18 +0300
Subject: [PATCH 0/2] Enable HiSilicon hip04 ethernet controller
Message-ID: <1428650180-9746-1-git-send-email-fathi.boudra@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches enable the ethernet controller on HiSilicon hip04
as documented in the device tree binding but not currently enabled.
It has been tested on real hardware with tftp boot + NFS root filesystem.

Fathi Boudra (2):
  ARM: dts: add HiSilicon hip04 ethernet controller resource
  ARM: defconfig: hisi: enable HiSilicon hip04 ethernet controller

 arch/arm/boot/dts/hip04.dtsi    | 49 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/configs/hisi_defconfig |  1 +
 2 files changed, 50 insertions(+)

-- 
2.1.4
