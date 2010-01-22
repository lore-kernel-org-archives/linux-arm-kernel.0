From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 22 Jan 2010 23:47:05 +0100
Subject: [PATCH 0/4] Add s3c64xx support to touchscreen driver
Message-ID: <b2e8f9f71001221447r56b29abboa81736fb1451cdde@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

these patches add support for the s3c64xx platforms to the touchscreen driver.
This was based on next-samsung in Ben Dook's tree.

These depend on:
[PATCH] ARM: SAMSUNG: Fix null pointer dereference in ADC driver

I'm not quite sure regarding the resources in patch 3, perhaps these should be
somehow shared with the ADC driver? (I also can't seem to figure out how the
s3c24xx handles this at the moment..)

Regards,
Maurus Cuelenaere
