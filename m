From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 29 Jan 2013 19:55:37 +0800
Subject: Section mismatch in drivers/mfd/vexpress-sysreg.c
Message-ID: <20130129115535.GH21504@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pawel,

I'm building v3.8-rc5 and seeing the following section mismatch warning
in drivers/mfd/vexpress-sysreg.c.

WARNING: drivers/mfd/built-in.o(.text+0x3108): Section mismatch in reference from the function vexpress_sysreg_probe() to the function .init.text:vexpress_sysreg_setup()
The function vexpress_sysreg_probe() references
the function __init vexpress_sysreg_setup().
This is often because vexpress_sysreg_probe lacks a __init
annotation or the annotation of vexpress_sysreg_setup is wrong.

Shawn
