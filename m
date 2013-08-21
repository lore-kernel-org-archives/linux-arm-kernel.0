From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Wed, 21 Aug 2013 11:07:38 +0800
Subject: [PATCH 0/4] Add freescale ftm pwm driver for Vybrid VF610 TOWER
Message-ID: <1377054462-6283-1-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series is the freescale ftm pwm implementation.
There are 8 channels most supported by the ftm pwm,
and there are two pwm modes:
- Center-Aligned PWM (CPWM) mode
- Edge-Aligned PWM (EPWM) mode

This implementation is only compatible with device tree definition.

Please feel free to comment the dt bindinds.

This patch series is based on linux-next and has been tested on Vybrid VF610TWR board using device tree.

Best Regards,
Xiubo Li
