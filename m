From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 20 May 2015 17:42:29 +0900
Subject: [RESEND PATCH 0/2] pinctrl: zynq: fix two bugs of zynq pinmux function
Message-ID: <1432111351-21336-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


I sent the previous one to linux-serial by mistake.
I am resending to linux-gpio, dropping linux-serial.
Sorry for noise.



Masahiro Yamada (2):
  pinctrl: zynq: fix DEFINE_ZYNQ_PINMUX_FUNCTION_MUX macro
  pinctrl: zynq: fix offset address for {SD0,SD1}_WP_CD_SEL

 drivers/pinctrl/pinctrl-zynq.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
1.9.1
