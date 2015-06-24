From: tony@atomide.com (Tony Lindgren)
Date: Wed, 24 Jun 2015 04:49:07 -0700
Subject: [PATCH 07/17] usb: musb: omap2430: use *syscon* framework to
 write to mailbox register
In-Reply-To: <1435060743-5511-8-git-send-email-kishon@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
 <1435060743-5511-8-git-send-email-kishon@ti.com>
Message-ID: <20150624114907.GF4156@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [150623 05:02]:
> Deprecate using phy-omap-control driver to write to the mailbox register
> and start using *syscon* framework to do the same.

All this stuff needs to go to some generic syscon USB phy
driver. Let's not start adding phy specific stuff to a USB
driver.

Regards,

Tony
