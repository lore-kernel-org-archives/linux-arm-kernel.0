From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 7 Feb 2012 16:29:03 +0100
Subject: Kirkwood, kernel 3.2, vmalloc region overlap, not starting up
Message-ID: <20120207152903.GA16238@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nils

There was a thread a while back about CONFIG_ARM_PATCH_PHYS_VIRT
causing problem with some kirkwood boards. Maybe try disabling this
and set CONFIG_PHYS_OFFSET=0x0.

However, it could be a different problem...

	 Andrew
