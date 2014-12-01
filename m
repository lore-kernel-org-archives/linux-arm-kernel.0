From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Mon,  1 Dec 2014 15:34:39 +0800
Subject: [PATCH 0/2] rockchip: efuse: add driver to support rk3288 efuse
Message-ID: <1417419281-9243-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In RK3288, there are two eFuse. One is organized as 32bits by 8 one-time
programmable electrical fuses with random access interface, and the other
is organized as 32bits by 32 one-time programmable electrical fuses.

Jianqun Xu (2):
  rockchip: efuse: add documentation for rk3288 efuse driver
  rockchip: efuse: add efuse driver for rk3288 efuse

 .../bindings/fuse/rockchip,rk3288-efuse.txt        |  14 ++
 arch/arm/mach-rockchip/efuse.c                     | 165 +++++++++++++++++++++
 arch/arm/mach-rockchip/efuse.h                     |  15 ++
 3 files changed, 194 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fuse/rockchip,rk3288-efuse.txt
 create mode 100644 arch/arm/mach-rockchip/efuse.c
 create mode 100644 arch/arm/mach-rockchip/efuse.h

-- 
1.9.1
