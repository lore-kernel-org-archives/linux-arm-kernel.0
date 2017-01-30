From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 30 Jan 2017 10:55:45 +0900
Subject: [RESEND PATCH 0/2] arm64: defconfig: enable some NAND config symbols
Message-ID: <1485741347-17363-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am resending this series to arm at kernel.org
as requested by Olof Johansson.

No code change since the previous post.



Masahiro Yamada (2):
  arm64: defconfig: enable CONFIG_MTD_BLOCK
  arm64: defconfig: enable CONFIG_MTD_NAND and CONFIG_MTD_NAND_DENALI_DT

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.7.4
