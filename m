From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 21 Nov 2012 16:53:12 +0100
Subject: [PATCH v5] linux,stdout-path helper
Message-ID: <20121121155312.GX4398@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following adds a helper for matching the linux,stdout-path property
in the chosen node and makes use of it in the i.MX serial and Atmel serial driver.

changes since v4:

 - add option support and check stdout-path too

changes since v3:

- move code from separate files to drivers/of/base.c and include/linux/of.h

changes since v2:

- move helper to OF core and make it independent of serial devices

changes since v1:

- move it out of the i.MX serial driver and make it generic for serial
  devices.

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss at lists.ozlabs.org
https://lists.ozlabs.org/listinfo/devicetree-discuss
