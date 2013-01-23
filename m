From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 23 Jan 2013 15:57:58 +0100
Subject: [PATCH 3.8-rc] i2c come back in mvebu_defconfig
Message-ID: <1358953079-1277-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

I have just realised that there were a problem when you applied my
patch ``arm: mvebu: Use dw-apb-uart instead of ns16650 as UART''. I
don't know what happened exactly but the commit remove the i2c support
whereas it was not the case in the patch I posted. Anyway this patch
fix it.

Thanks,

Gregory CLEMENT (1):
  arm: mvebu: i2c come back in defconfig

 arch/arm/configs/mvebu_defconfig |    2 ++
 1 file changed, 2 insertions(+)

-- 
1.7.9.5
