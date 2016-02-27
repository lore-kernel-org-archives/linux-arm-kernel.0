From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 27 Feb 2016 21:38:43 +0100
Subject: [GIT PULL] pxa dt for v4.6
Message-ID: <87lh65rir0.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd, Kevin, Olof,

Please consider this device-tree changes for pxa for v4.6 cycle.
There is only a single patch in this one.

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-dt-4.6

for you to fetch changes up to 07c6b2d01d351f0512ed7145625265e435ab3240:

  ARM: dts: pxa: fix dma engine node to pxa3xx-nand (2016-02-26 23:30:29 +0100)

----------------------------------------------------------------
This device-tree pxa update brings :
 - a single fix for nand dmaengine node

----------------------------------------------------------------
Robert Jarzmik (1):
      ARM: dts: pxa: fix dma engine node to pxa3xx-nand

 arch/arm/boot/dts/pxa3xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Cheers.

-- 
Robert
