From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 06 Jun 2012 11:28:38 +0300
Subject: [PATCH v3 03/12] usb: ehci-hcd: notify phy when connect change
In-Reply-To: <201206051703.17691.marex@denx.de>
References: <Pine.LNX.4.44L0.1206051025540.1542-100000@iolanthe.rowland.org>
 <201206051703.17691.marex@denx.de>
Message-ID: <87sje89749.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut <marex@denx.de> writes:

> Does this unlikely() have any effect on ARM/MIPS/PPC, where this chipidea IP is 
> used ? Or is there some x86 device sporting this IP too?

Of course there is. :)

Regards,
--
Alex
