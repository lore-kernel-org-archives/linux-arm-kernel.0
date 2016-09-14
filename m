From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 14 Sep 2016 11:06:51 -0700
Subject: [GIT PULL] Amlogic DT updates for v4.9
Message-ID: <7h1t0mmk3o.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Just a single patch for 32-bit DT changes for Amlogic SoCs this round.
Please pull.

Thanks,

Kevin

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt

for you to fetch changes up to a29c830a28721bb684c212206b2bab6dc53d0cb4:

  ARM: dts: meson8b: Add Meson8b PWM Controller nodes (2016-09-07 13:16:13 -0700)

----------------------------------------------------------------
Amlogic DT updates for v4.9
- add PWM support

----------------------------------------------------------------
Neil Armstrong (1):
      ARM: dts: meson8b: Add Meson8b PWM Controller nodes

 arch/arm/boot/dts/meson8b.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
