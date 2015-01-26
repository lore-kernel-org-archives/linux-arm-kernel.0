From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Mon, 26 Jan 2015 15:54:38 +0100
Subject: [PATCH v2 0/2] pm: at91: pm_slowclock: improve reliability of
 suspend/resume
In-Reply-To: <1422265068-22974-1-git-send-email-wenyou.yang@atmel.com>
References: <1422265068-22974-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1422284080-32446-1-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
  * I only splitted my patch in two

Sylvain Rochet (2):
  pm: at91: pm_slowclock: fix suspend/resume hang up in timeouts
  pm: at91: pm_slowclock: remove clocks which are already stopped when
    entering slow clock mode

 arch/arm/mach-at91/pm.c           | 12 ++++++++
 arch/arm/mach-at91/pm_slowclock.S | 62 ++-------------------------------------
 2 files changed, 15 insertions(+), 59 deletions(-)

-- 
2.1.4
