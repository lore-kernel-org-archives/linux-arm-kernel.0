From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 27 Dec 2013 15:59:54 +0100
Subject: [PATCH v2 0/5] input: Add new sun4i-ts driver for Allwinner sunxi
Message-ID: <1388156399-29677-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dimitri et al,

Here is v2 of my sun4i-ts patch-set.

Changes since v1:
-Use devm_kzalloc and devm_hwmon_device_register_with_groups as suggested
 by Guenter Roeck
-Various small cleanups suggested by Thomas Petazzoni
-Add open/close methods and enable/disable the input related interrupts from
 there as suggested by you (Dimitri)

Assuming there is no more feedback, can you please add the 1st 2 patches
to your tree for 3.14 ?

Maxime, can you please add the dts bits to your dts tree for 3.14 ?

Thanks & Regards,

Hans
