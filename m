From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:49:32 +0200
Subject: [PATCH 0099/1529] Fix typo
Message-ID: <20160521114932.4505-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-integrator/pci_v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index 2565f0e..7ce4495 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -324,7 +324,7 @@ static u64 pre_mem_pci_sz;
  * configuration address space, you present the V3 with the following pattern
  * (which is very nearly a type 1 (except that the lower two bits are 00 and
  * not 01).   In order for this mapping to work you need to set up one of
- * the local to PCI aperatures to 16Mbytes in length translating to
+ * the local to PCI apertures to 16Mbytes in length translating to
  * PCI configuration space starting at 0x0000.0000.
  *
  * PCI configuration cycles look like this:
-- 
2.8.2.534.g1f66975
