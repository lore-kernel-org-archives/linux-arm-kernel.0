From: linux@prisktech.co.nz (Tony Prisk)
Date: Mon, 19 Nov 2012 15:06:18 +1300
Subject: [PATCH 0/2] pwm fixes for 3.8
Message-ID: <1353290780-19413-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Theirry,

As discussed, here is the patch to correct the issue created by enabling
disabling the pwm clock during pwm_enable/_disable. A second patch is
including which fixes a build error introduced in the same patch.

These should be applied on top of the previous patch.

Tony Prisk (2):
  Fix build error in pwm-vt8500.c
  pwm: vt8500: Ensure pwm clock is enabled during pwm_config

 drivers/pwm/pwm-vt8500.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
1.7.9.5
