From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 15 Oct 2013 21:50:33 -0700
Subject: [PATCH v2] ARM: cci driver need big endian fixes in asm code
Message-ID: <1381899034-420-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

This is version 2 of cci big endian fix. Idea of this
way of fixing was suggested by Ben Dooks [1]. Compared to
previous solution this one does not use ifdefs and looks
much cleaner.

This was tested on TC2 both LE and BE, CONFIG_ARM_CCI
was enabled.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/203248.html

Thanks,
Victor

Victor Kamensky (1):
  ARM: cci driver need big endian fixes in asm code

 drivers/bus/arm-cci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
1.8.1.4
