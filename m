From: bharatku@xilinx.com (bharat kumar gogada)
Date: Wed, 7 Oct 2015 14:53:03 +0000 (UTC)
Subject: Irq domain for legacy interrupts
Message-ID: <loom.20151007T164737-541@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

why do we need a irq domain for legacy interrupts ? Do we need any specific
parameter in device tree other that interrupt-map, interrupt-map-mask, for
handling with irq domain ? when will the .map method in struct
irq_domain_ops get invoked for legacy interrupts ?
