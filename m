From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 28 Oct 2012 23:19:08 +0100
Subject: [PATCH v3 4/4] irqchip: add to the directories part of the IRQ
 subsystem in MAINTAINERS
In-Reply-To: <1351462748-5224-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351462748-5224-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1351462748-5224-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the drivers/irqchip/ directory is getting more code, it needs
a maintainer. The obvious maintainer for it is Thomas Gleixner, who is
maintaining the overall IRQ subsystem. So we add drivers/irqchip/ in
the list of directories that are part of the IRQ subsystem.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Rob Herring <rob.herring@calxeda.com>
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 027ec2b..70bd390 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4034,6 +4034,7 @@ M:	Thomas Gleixner <tglx@linutronix.de>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
 F:	kernel/irq/
+F:	drivers/irqchip/
 
 IRQ DOMAINS (IRQ NUMBER MAPPING LIBRARY)
 M:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
-- 
1.7.9.5
