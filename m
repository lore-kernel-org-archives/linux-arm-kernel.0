From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jul 2011 14:10:30 +0100
Subject: [PATCH 0/9] PL08x further cleanups
Message-ID: <20110705131030.GE8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is the remainder of the PL08x work I did earlier
this year while trying to get the ARM platforms working with DMA.

Unfortunately, due to the state of the hardware, I was not able to
properly test these changes.  However, they do compile, and I think
if others are going to be looking at the PL08x DMA engine driver,
they're worth having.

Linus, can you check these out on your hardware please?
