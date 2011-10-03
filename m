From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Oct 2011 11:40:26 +0200
Subject: [PATCH 15/30] usb/musb: use a Kconfig choice to pick the right
	DMA method
In-Reply-To: <20111002221050.GA25790@legolas.emea.dhcp.ti.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1546914.88vcgxkfJf@wuerfel>
	<20111002221050.GA25790@legolas.emea.dhcp.ti.com>
Message-ID: <3529819.LQllWhb43D@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 October 2011 01:10:51 Felipe Balbi wrote:
> Anyway, I'll take your patches in, but their too late for this merge
> window  I already sent my last pull to Greg.

No problem. I need the full set of arm-randconfig patches upstream in order
to make randconfig work in general, and that's not happening for 3.2
anyway. Right now, I'm just trying to as many patches as possible into
maintainer trees.

Is your tree part of linux-next, or will it only show up after the merge
window once Greg has pulled your first set for 3.3?

	Arnd
