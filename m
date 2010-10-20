From: sguinot@lacie.com (Simon Guinot)
Date: Wed, 20 Oct 2010 18:37:25 +0200
Subject: [PATCH v2] hwmon: add generic GPIO fan driver
Message-ID: <1287592646-18109-1-git-send-email-sguinot@lacie.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

Here is an updated version for the gpio-fan driver.

v2 changes :

- add support for sysfs attributes fan1_target, fan1_min and fan1_max
- simplify the pwm interface
- add power management support
- fix interrupt handling (allow to share the fan alarm irq)
- fix bugs mostly addressed during code review...

Documentation is still missing.

Thanks,

Simon
