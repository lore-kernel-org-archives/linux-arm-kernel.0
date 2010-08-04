From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  4 Aug 2010 19:24:52 +0200
Subject: [PATCH 5/5] arm: Enable support for virtio
In-Reply-To: <1280942692-32079-1-git-send-email-arnd@arndb.de>
References: <1280942692-32079-1-git-send-email-arnd@arndb.de>
Message-ID: <1280942692-32079-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Qemu can use virtio-pci based devices when emulating a
machine with PCI. This adds the necessary Kconfig entry
that allows users to select those drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index dd452ee..4920e30 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1093,6 +1093,8 @@ config PCI_HOST_XILINX
 
 source "drivers/pci/Kconfig"
 
+source "drivers/virtio/Kconfig"
+
 source "drivers/pcmcia/Kconfig"
 
 endmenu
-- 
1.7.1
