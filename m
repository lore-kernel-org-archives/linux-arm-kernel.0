From: yh.huang@mediatek.com (YH Huang)
Date: Mon, 29 Jun 2015 23:03:29 +0800
Subject: [PATCH v3 0/2] Add MediaTek display PWM driver 
Message-ID: <1435590211-38854-1-git-send-email-yh.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add the use of display PWM driver and documentation 
for Mediatek SoCs. The driver is used to support the backlight of 
the panel. This is based on v4.1-rc1.

Change in v3:
1. Add suspend/resume function
2. Fix the formula for high_width calculation
3. Rewrite some code to make it easier to read
4. Add more information in the commit message
