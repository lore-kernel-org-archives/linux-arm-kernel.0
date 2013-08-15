From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Aug 2013 12:44:01 +0100
Subject: Build failure: versatile express
Message-ID: <20130815114401.GD23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/built-in.o: In function `vexpress_reset_do.clone.0':
iio-trig-interrupt.c:(.text+0x1aff38): undefined reference to `__vexpress_config_func_get'
iio-trig-interrupt.c:(.text+0x1aff4c): undefined reference to `vexpress_config_write'

The filename above will be misleading due to the way the toolchain works.

Configs etc at http://www.arm.linux.org.uk/developer/build/

Tree is arm-soc tip plus my tip plus Linus' tip.  This error has been
knocking about for some time now.
