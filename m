From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 14 Jun 2016 13:50:54 -0700
Subject: [GIT PULL] Amlogic DT updates for v4.8 (v2)
Message-ID: <7hziqnbikx.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a respin of the Amlogic DT branch with only 32-bit DT stuff.

Kevin



The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt

for you to fetch changes up to cad059c6e6b2185a068453608f155e9e8a64af39:

  ARM: dts: amlogic: Enable Reset Controller on Meson8b platforms (2016-06-14 13:36:56 -0700)

----------------------------------------------------------------
Amlogic DT changes for v4.8
- add reset driver for meson8b

----------------------------------------------------------------
Neil Armstrong (1):
      ARM: dts: amlogic: Enable Reset Controller on Meson8b platforms

 arch/arm/boot/dts/meson8b.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)
