From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 15 Mar 2015 00:57:29 +0100
Subject: [GIT PULL] ARM: rockchip: small fixes for 4.0-rc
Message-ID: <3637038.xZyfPJIQzf@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

a small issue surfaced with the new gmac node on rk3288 which is missing a
	status = "disabled";
in the rk3288.dtsi and thus enabling the mac unconditionally.
The second patch in that branch simply adds a rockchip regexp to MAINTAINERS, so
that it also matches stuff like the (slightly) new rockchip drm stuff.

So if acceptable, please pull

Thanks
Heiko


The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.0-rockchip-armfixes1

for you to fetch changes up to 54b0bc602541fcc2dd9f2480623c00552e0b220e:

  ARM: dts: rockchip: disable gmac by default in rk3288.dtsi (2015-03-14 19:35:26 +0100)

----------------------------------------------------------------
Adding a default-disabled state to the new gmac node and an
update to the MAINTAINERS entry adding a rockchip regexp entry.

----------------------------------------------------------------
Alexandru M Stan (1):
      ARM: dts: rockchip: disable gmac by default in rk3288.dtsi

Heiko Stuebner (1):
      MAINTAINERS: add rockchip regexp to the ARM/Rockchip entry

 MAINTAINERS                   | 1 +
 arch/arm/boot/dts/rk3288.dtsi | 1 +
 2 files changed, 2 insertions(+)
