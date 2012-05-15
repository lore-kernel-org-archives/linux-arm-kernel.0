From: jgq516@gmail.com (jgq516 at gmail.com)
Date: Tue, 15 May 2012 15:25:54 +0800
Subject: Compile err with raumfeld_defconfig
Message-ID: <1337066754-20520-1-git-send-email-jgq516@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Does somebody notice this compile err with raumfeld_defconfig as follows?

drivers/input/touchscreen/eeti_ts.c: In function 'eeti_ts_irq_active':
drivers/input/touchscreen/eeti_ts.c:65:2: error: implicit declaration of function 'irq_to_gpio'

Regards,
Xiao
