From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 04 Aug 2017 11:16:29 +0200
Subject: [GIT PULL] Rockchip dts32 fixes for 4.13
Message-ID: <3943171.Z7m20BX0pe@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

please find below a fixup for 32bit devicetree parts for 4.13.
As the tag describes it is meant to stop proliferation of the
wrong example through copy-pastes.

So please pull

Thanks
Heiko


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.13-rockchip-dts32fixes-1

for you to fetch changes up to ca12437303f35b0a5b97c856d88886ce9df6a0d7:

  ARM: dts: rockchip: fix mali gpu node on rk3288 (2017-07-16 17:04:50 +0200)

----------------------------------------------------------------
Fix for the recently added mali dt support. The example
showed a wrong value, so fix it before it gets copy-pasted
to much.

----------------------------------------------------------------
Heiko Stuebner (2):
      dt-bindings: gpu: drop wrong compatible from midgard binding example
      ARM: dts: rockchip: fix mali gpu node on rk3288

 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt | 2 +-
 arch/arm/boot/dts/rk3288.dtsi                              | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
