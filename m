From: zalan.blenessy@gmail.com (Zalan Blenessy)
Date: Wed, 25 Dec 2013 13:11:05 +0100
Subject: [PATCH 0/1] ARM: sunxi: select ARM_PSCI
Message-ID: <1387973466-5067-1-git-send-email-zalan.blenessy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

This patch enabled ARM_PSCI by default, which is necessary 
when the CPU (e.g. sun7i) is intialized from u-boot.

BR, Zalan Blenessy

Zalan Blenessy (1):
  ARM: sunxi: select ARM_PSCI

 arch/arm/mach-sunxi/Kconfig |    1 +
 1 file changed, 1 insertion(+)

-- 
1.7.10.4
