From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 20 Sep 2012 21:33:45 +0200
Subject: My collection of IXP4xx patches for the next window
Message-ID: <m3txus4hgm.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is (more or less) what I wish to push in the next window:

Arnd Bergmann (1):
      ARM: IXP4xx: use __iomem pointers for MMIO

Krzysztof Ha?asa (10):
      IXP4xx: Fix Goramo MultiLink platform compilation.
      IXP4xx: Fix off-by-one bug in Goramo MultiLink platform.
      IXP4xx: HW pseudo-random generator is available on IXP45x/46x only.
      IXP4xx: ixp4xx_crypto driver requires Queue Manager and NPE drivers.
      ARM: fix DMA-bounce code to allow sync from_device and to_device with bidirectional mappings.
      IXP4xx: Remove time limit for PCI TRDY to enable use of slow devices.
      WAN: Remove redundant HDLC info printed by IXP4xx HSS driver.
      IXP4xx crypto: MOD_AES{128,192,256} already include key size.
      IXP4xx: Always ioremap() Queue Manager MMIO region at boot.
      IXP4xx: map CPU config registers within VMALLOC region.

Tim Gardner (1):
      ixp4xx: Declare MODULE_FIRMWARE usage

I will send not yet posted patches. Please comment.
-- 
Krzysztof Halasa
