From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 15 Apr 2014 12:11:28 +0200
Subject: [GIT PULL] ARM: rockchip: fixes for  v3.15
Message-ID: <2072835.sS0OefbP8P@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.15-rockchip-fixes1

for you to fetch changes up to 5c4348c1f959234664e4667f428cf82b3b8a7c2c:

  ARM: rockchip: fix copy'n'paste error in smp error messages (2014-04-15 11:17:00 +0200)

----------------------------------------------------------------
Fixing uart-rx pull settings and a copy'n'paste error in a smp message

----------------------------------------------------------------
Heiko Stuebner (1):
      ARM: rockchip: fix copy'n'paste error in smp error messages

Max Schwarz (1):
      ARM: rockchip: rk3188: enable pull-ups on UART RX pins

 arch/arm/boot/dts/rk3188.dtsi    | 8 ++++----
 arch/arm/mach-rockchip/platsmp.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)
