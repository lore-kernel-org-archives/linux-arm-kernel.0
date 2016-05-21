From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:50:43 +0200
Subject: [PATCH 0110/1529] Fix typo
Message-ID: <20160521115043.5071-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-pxa/mioa701.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 38a96a1..08c6909 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -423,12 +423,12 @@ static struct platform_device docg3 = {
 /*
  * Suspend/Resume bootstrap management
  *
- * MIO A701 reboot sequence is highly ROM dependent. From the one dissassembled,
+ * MIO A701 reboot sequence is highly ROM dependent. From the one disassembled,
  * this sequence is as follows :
  *   - disables interrupts
  *   - initialize SDRAM (self refresh RAM into active RAM)
  *   - initialize GPIOs (depends on value at 0xa020b020)
- *   - initialize coprossessors
+ *   - initialize coprocessors
  *   - if edge detect on PWR_SCL(GPIO3), then proceed to cold start
  *   - or if value at 0xa020b000 not equal to 0x0f0f0f0f, proceed to cold start
  *   - else do a resume, ie. jump to addr 0xa0100000
-- 
2.8.2.534.g1f66975
