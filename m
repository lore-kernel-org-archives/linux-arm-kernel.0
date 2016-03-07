From: carlo@caione.org (Carlo Caione)
Date: Mon, 7 Mar 2016 13:21:10 +0100
Subject: Amlogic Meson ARM64 update for 4.6
Message-ID: <CAOQ7t2b08xSHauV_Ou=bAdr3WwzSntUmfADkZmOVngpZCtqbuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95:

  Linux 4.5-rc3 (2016-02-07 15:38:30 -0800)

are available in the git repository at:

  https://github.com/carlocaione/linux-meson.git tags/for-v4.6/gxbb-arm64

for you to fetch changes up to 451e9e54e259f1f223763e191393c47383674256:

  ARM64: Enable Amlogic Meson GXBaby platform (2016-03-07 10:44:31 +0100)

----------------------------------------------------------------
Provide the ARCH_MESON Kconfig symbol for the Amlogic S905 SoCs.

----------------------------------------------------------------
Andreas F?rber (1):
      ARM64: Enable Amlogic Meson GXBaby platform

 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)
