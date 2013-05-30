From: maxime.ripard@free-electrons.com (maxime.ripard at free-electrons.com)
Date: Thu, 30 May 2013 15:53:51 +0200
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <20130529124108.GA415@pengutronix.de>
References: <51A5A808.2070803@digi.com>
 <F281D0F91ED19E4D8E63A7504E8A649803E8A3F3@039-SN2MPN1-021.039d.mgd.msft.net>
 <20130529075044.GC3293@lukather>
 <F281D0F91ED19E4D8E63A7504E8A649803E8A4D0@039-SN2MPN1-021.039d.mgd.msft.net>
 <20130529101332.GC7356@pengutronix.de>
 <20130529121916.GF3293@lukather>
 <20130529124108.GA415@pengutronix.de>
Message-ID: <20130530135351.GH9799@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Wed, May 29, 2013 at 02:41:08PM +0200, Michael Grzeschik wrote:
> Peters patches need some more care, as they are not cleanly sperated.
> One patch e.g. adds an delayed worker to handle the otg events. Another
> one above that patch is removing the worker afterwards.

I see, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
