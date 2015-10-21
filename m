From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 21 Oct 2015 22:59:38 +0200
Subject: [GIT PULLv2] at91: dt for 4.4 #2
Message-ID: <20151021205938.GA18600@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

As discussed, version 2 of that pull request that removes the last patch
to avoid the dependency on the MFD subsystem.

The following changes since commit a9b672a636a599cc052afcb6837e3177dc53c143:

  ARM: at91/dt: sama5d2 Xplained: add device pin muxing (2015-09-23 16:26:47 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-dt2

for you to fetch changes up to 512fc048e4fdc39f43e78af7e2fed5047d651979:

  ARM: at91/dt: sama5d2: add missing devices (2015-10-19 21:22:21 +0200)

----------------------------------------------------------------
Second batch of DT changes for 4.4:
- some DT fixes: pullups, disabled property
- the PMC is now a syscon
- great improvement of sama5d2 support

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: at91/dt: use syscon for PMC

Gregory CLEMENT (1):
      ARM: at91/dt: sama5d4: add the macb1 node

Ludovic Desroches (1):
      ARM: at91/dt: sama5d2: add missing devices

Michael Opdenacker (1):
      ARM: at91/dt: fix "disabled" property on at91rm9200

Sylvain Rochet (1):
      ARM: at91/dt: add pullup on mmc2 data signals

Wenyou Yang (1):
      ARM: at91/dt: sama5d2_xplained: add regulator nodes

 arch/arm/boot/dts/at91-sama5d2_xplained.dts |  57 ++++++++++
 arch/arm/boot/dts/at91rm9200.dtsi           |   8 +-
 arch/arm/boot/dts/at91sam9260.dtsi          |   2 +-
 arch/arm/boot/dts/at91sam9261.dtsi          |   2 +-
 arch/arm/boot/dts/at91sam9263.dtsi          |   2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi          |   2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi          |   2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi           |   2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi           |   2 +-
 arch/arm/boot/dts/sama5d2.dtsi              | 154 +++++++++++++++++++++++++++-
 arch/arm/boot/dts/sama5d3.dtsi              |   2 +-
 arch/arm/boot/dts/sama5d3_mci2.dtsi         |   6 +-
 arch/arm/boot/dts/sama5d4.dtsi              |  32 +++++-
 13 files changed, 254 insertions(+), 19 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151021/3b891fc5/attachment.sig>
