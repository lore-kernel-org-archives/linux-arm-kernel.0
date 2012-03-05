From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon,  5 Mar 2012 20:21:44 +0800
Subject: [PATCH v2 0/7] ARM: mmp: support OF on pxa168
Message-ID: <1330950111-30797-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add OF support on gpio/serial/rtc/i2c components in pxa168 aspenite.

Changelog v2:
1. Append interrupt-names property in rtc-sa1100, gpio-pxa driver.
2. Append alias in i2c-pxa driver.
3. Avoid embed CONFIG_OF in i2c-pxa driver.
