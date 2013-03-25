From: avinashphilip@ti.com (Philip Avinash)
Date: Mon, 25 Mar 2013 12:34:51 +0530
Subject: [PATCH 0/2] Update device tree binding document for pwm-tiehrpwm &
 pwm-tiecap
Message-ID: <1364195093-1357-1-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update device tree document of pwm-tiehrpwm & pwm-tiecap in order to reflect the
usage of similar modules in both da850 and am33xx platforms.

Philip Avinash (2):
  pwm: pwm-tiecap: Update device-tree binding document
  pwm: pwm-tiehrpwm: Update device-tree binding document

 .../devicetree/bindings/pwm/pwm-tiecap.txt         |   12 ++++++++++--
 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |   12 ++++++++++--
 2 files changed, 20 insertions(+), 4 deletions(-)

-- 
1.7.9.5
