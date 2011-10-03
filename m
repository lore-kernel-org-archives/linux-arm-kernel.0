From: balbi@ti.com (Felipe Balbi)
Date: Mon, 3 Oct 2011 13:07:05 +0300
Subject: [PATCH 15/30] usb/musb: use a Kconfig choice to pick the right
	DMA method
In-Reply-To: <3529819.LQllWhb43D@wuerfel>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1546914.88vcgxkfJf@wuerfel>
	<20111002221050.GA25790@legolas.emea.dhcp.ti.com>
	<3529819.LQllWhb43D@wuerfel>
Message-ID: <20111003100704.GD3363@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 03, 2011 at 11:40:26AM +0200, Arnd Bergmann wrote:
> On Monday 03 October 2011 01:10:51 Felipe Balbi wrote:
> > Anyway, I'll take your patches in, but their too late for this merge
> > window  I already sent my last pull to Greg.
> 
> No problem. I need the full set of arm-randconfig patches upstream in order
> to make randconfig work in general, and that's not happening for 3.2
> anyway. Right now, I'm just trying to as many patches as possible into
> maintainer trees.
> 
> Is your tree part of linux-next, or will it only show up after the merge
> window once Greg has pulled your first set for 3.3?

My tree isn't in linux-next yet so my patches go to Greg and from there
to -next.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111003/fd2867bf/attachment.sig>
