From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 18 Jul 2015 00:10:42 +0200
Subject: [GIT PULL] pxa-dt for v4.3
Message-ID: <87wpxyfna5.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof,

This is the pxa pull request for 4.3 device-tree. It is mostly dma centric, with
one fix and 2 new IPs support, camera host and usb host.

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/tags/pxa-dt-4.3

for you to fetch changes up to fb18539b3c8f03e550b8afb21cf53db2a2235dbe:

  ARM: dts: pxa: fix power i2c definition (2015-07-10 22:29:22 +0200)

----------------------------------------------------------------
This device-tree pxa update brings :
 - dma nodes after dmaengine pxa_dma driver merge
 - camera driver
 - usb host controller

----------------------------------------------------------------
Robert Jarzmik (6):
      ARM: dts: pxa: add dma controller
      ARM: dts: pxa: add dma engine node to pxa3xx-nand
      ARM: dts: pxa: add dma pxamci nodes to pxa3xx
      ARM: dts: pxa: add embedded pxa camera capture interface
      ARM: dts: pxa: add the usb host controller
      ARM: dts: pxa: fix power i2c definition

 arch/arm/boot/dts/pxa27x.dtsi | 36 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/pxa2xx.dtsi |  4 ++++
 arch/arm/boot/dts/pxa3xx.dtsi | 52 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)

Cheers.

-- 
Robert
