From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Jan 2013 11:11:17 +0000
Subject: OMAP4 randconfig failure: Zynq
Message-ID: <20130124111117.GU23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP4 randconfig build last night failed with this error:

arch/arm/mach-zynq/common.c:99:14: error: 'irqchip_init' undeclared here (not in a function)

Full details at the usual place - 
http://www.arm.linux.org.uk/developer/build/
