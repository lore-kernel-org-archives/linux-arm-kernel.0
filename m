From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Thu, 2 Jan 2014 17:57:00 +0800
Subject: [PATCHv8 0/4] Add Freescale FTM PWM driver.
Message-ID: <1388656624-26570-1-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is the Freescale FTM PWM implementation. And there
are 8 channels most supported by the FTM PWM. This implementation is
only compatible with device tree definition.

This patch series is based on linux-next and has been tested on Vybrid
VF610 Tower board using device tree.



Changes in v8:
- Fix some issues pointed by Thierry.
- Fix the _readl/_writel of sparse check.

- And the ftm_readl()/ftm_writel() are just copied from the
  readl()/writel(), and then add the big endian check.



Changes in v7:
- Add big-endian mode support.
- Add FTM mutex lock.
- Add period time check with the current running pwm(s).
- Recode the counter clock source selecting.
- Sort some header files alphabetically, etc.

[snip] v1~v6
