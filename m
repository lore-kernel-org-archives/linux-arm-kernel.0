From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 24 Aug 2017 12:04:47 +0200
Subject: [GIT PULL] second round of Rockchip soc32 changes for 4.14
Message-ID: <1512183.GTgy5kOUk8@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

forgot that I had another kconfig option for LPAE support sitting
in my tree when sending the devicetree pulls. So please find below
enablement of ARCH_DMA_ADDR_T_64BIT for LPAE builds.


Thanks
Heiko


The following changes since commit bf3c4b517c2e2217e6cd53bc7a44e321bb799d75:

  ARM: rockchip: enable ZONE_DMA for non 64-bit capable peripherals (2017-08-01 00:57:59 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.14-rockchip-soc32-2

for you to fetch changes up to 58ed5e5733b293f03a302612d395ac747021b946:

  ARM: rockchip: select ARCH_DMA_ADDR_T_64BIT for LPAE (2017-08-06 13:06:05 +0200)

----------------------------------------------------------------
Enable the ARCH_DMA_ADDR_T_64BIT kconfig option for LPAE builds,
as some peripherals like the Mali gpu do support 64bit dma addresses.

----------------------------------------------------------------
Tao Huang (1):
      ARM: rockchip: select ARCH_DMA_ADDR_T_64BIT for LPAE

 arch/arm/mach-rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)
