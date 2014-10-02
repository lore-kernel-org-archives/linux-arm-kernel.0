From: carlo@caione.org (Carlo Caione)
Date: Thu, 2 Oct 2014 22:51:00 +0200
Subject: [GIT PULL] ARM: meson: last DTS change for 3.18
Message-ID: <20141002205100.GA19646@nuc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
this patch from the patchset
http://www.spinics.net/lists/arm-kernel/msg363927.html is not in the
arm-soc tree. The other patches from the patchset have been already
taken by Guenter http://server.roeck-us.net/patch/1926/
Hopefully you can pull it in.

Thank you.

The following changes since commit 4394a0014597bd53e2d9bbc69d091e3fbde7d00c:

  Merge tag 'mvebu-dt-3.18-2' of git://git.infradead.org/linux-mvebu into next/dt (2014-10-02 17:08:24 +0200)

are available in the git repository at:


  https://github.com/carlocaione/linux-meson.git tags/meson-wdt-dt-3.18

for you to fetch changes up to d4ac2cfea724d3874ce3f1f624bcd40e78b1a9d4:

  ARM: DTS: meson: update DTSI to add watchdog node (2014-10-02 22:27:42 +0200)

----------------------------------------------------------------
This patch adds the support for the Meson6 watchdog in the DTSI

----------------------------------------------------------------
Carlo Caione (1):
      ARM: DTS: meson: update DTSI to add watchdog node

 arch/arm/boot/dts/meson.dtsi | 5 +++++
 1 file changed, 5 insertions(+)
-- 
Carlo Caione
