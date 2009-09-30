From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Wed, 30 Sep 2009 11:06:07 +0200
Subject: [at91sam9g45] touch screen not detected by Angstrom Linux
Message-ID: <4AC31F7F.6090001@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nicolas,

I could successfully apply your touch screen drivers to 2.6.32-rc2:

2.6.30-at91-exp-0045-input-atmel_tsadcc-touchscreen-use-platform-paramet.patch
2.6.30-at91-exp-0046-at91-input-platform-parameters-for-atmel_tsadcc-in.patch
2.6.30-at91-exp-0047-at91-input-touchscreen-support-for-at91sam9g45ekes.patch

Here dmesg output for 2.6.32-rc2:

atmel_tsadcc atmel_tsadcc: Master clock is set at: 133333333 Hz
atmel_tsadcc atmel_tsadcc: Prescaler is set at: 221
input: atmel touch screen controller as /devices/platform/atmel_tsadcc/input/input1

Here dmesg output for 2.6.27 where touch screen is working under Angstrom Linux:

atmel_tsadcc atmel_tsadcc: Master clock is set at: 133333333 Hz
atmel_tsadcc atmel_tsadcc: Prescaler is set at: 221
input: atmel touch screen controller as /class/input/input1

The device is working if I read /dev/input/event1, but I'm not able to get it working under Angstrom Linux. Any ideas?

Regards,
Yegor
