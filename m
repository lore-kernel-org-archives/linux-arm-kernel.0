From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 10 Jan 2013 13:15:13 +0100
Subject: [PATCH] arm: mvebu: Fix memory size for Armada 370 DB
Message-ID: <1357820114-16855-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jason and Andrew,

After reviewing patch from Florian for the Armada 370 RD, I realized
that we made a mistake in the Armada 370 DB dts. The board comes with
1GB of RAM and we declared only 512MB. This patch fixes this and is
aimed to be applied on a 3.8 kernel. To be sure there were no problem
with the ``extra'' 512MB I ran memtest on the whole memory without
getting any erros.

Thanks,

Gregory CLEMENT (1):
  arm: mvebu: Fix memory size for Armada 370 DB

 arch/arm/boot/dts/armada-370-db.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.7.9.5
