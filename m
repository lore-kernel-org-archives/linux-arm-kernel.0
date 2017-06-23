From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 22 Jun 2017 18:08:35 -0700
Subject: [RFC 0/2] PM / suspend: Add platform_suspend_target_state()
In-Reply-To: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
Message-ID: <20170623010837.11199-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series implements the idea discussed in this thread:

https://www.spinics.net/lists/arm-kernel/msg590068.html

The last patch is relative to the pending submission of the Broadcom STB
S2/S3/S5 suspend/resume code that can be found below, and is provided
as an example of how this can be useful.

https://lkml.org/lkml/2017/6/16/737

Florian Fainelli (2):
  PM / suspend: Add platform_suspend_target_state()
  soc: bcm: brcmstb: PM: Implement target_state callback

 drivers/soc/bcm/brcmstb/pm/pm-arm.c | 15 +++++++++++++++
 include/linux/suspend.h             | 12 ++++++++++++
 kernel/power/suspend.c              | 15 +++++++++++++++
 3 files changed, 42 insertions(+)

-- 
2.9.3
