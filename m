From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 23 Jan 2014 10:04:56 +0100
Subject: [PATCHv2 2/2] pwm: imx: support polarity inversion
In-Reply-To: <20140123083714.3c6e86ae@ipc1.ka-ro>
References: <20140123083714.3c6e86ae@ipc1.ka-ro>
Message-ID: <1390467898-9216-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I thinking more of the following. I haven't tested it, but it has a negative
diffstat, so it must be good ;)

Sascha

----------------------------------------------------------------
Sascha Hauer (2):
      PWM: let of_xlate handlers check args count
      PWM: handle additional flags in of_pwm_simple_xlate

 drivers/pwm/core.c            | 41 +++++++----------------------------------
 drivers/pwm/pwm-atmel-tcb.c   |  2 --
 drivers/pwm/pwm-renesas-tpu.c |  2 --
 drivers/pwm/pwm-samsung.c     |  3 ---
 drivers/pwm/pwm-tiecap.c      |  2 --
 drivers/pwm/pwm-tiehrpwm.c    |  2 --
 drivers/pwm/pwm-vt8500.c      |  2 --
 include/linux/pwm.h           |  3 ---
 8 files changed, 7 insertions(+), 50 deletions(-)
