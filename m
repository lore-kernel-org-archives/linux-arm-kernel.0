From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Aug 2013 12:41:50 +0100
Subject: Build error: kvm/reset.c
Message-ID: <20130815114150.GC23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Last night's omap4430-sdp randconfig failed with this error in the KVM code:

arch/arm/kvm/reset.c:43:2: error: unknown field 'irq' specified in initializer

Configs etc at http://www.arm.linux.org.uk/developer/build/

Tree is my tip plus arm-soc tip plus Linus' tip.
