From: yong.shen@linaro.org (yong.shen at linaro.org)
Date: Fri, 11 Feb 2011 10:36:11 +0100
Subject: [PATCH v2 0/2] ARM: IMX5: cpuidle driver 
Message-ID: <1297416973-32740-1-git-send-email-yong.shen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


change log:
1. move code to arch/arm/mach-mx5/, since it is cpu-type specific
2. provide a interface for various board to register board-specific params.
