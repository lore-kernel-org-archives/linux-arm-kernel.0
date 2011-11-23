From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Wed, 23 Nov 2011 23:49:01 +0100
Subject: [PATCH v3 1/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x
 SSP/SPI) driver
In-Reply-To: <1322081102.2448.YahooMailClassic@web29004.mail.ird.yahoo.com>
References: <1322081102.2448.YahooMailClassic@web29004.mail.ird.yahoo.com>
Message-ID: <1322088541.18388.16.camel@flow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 23.11.2011, 20:45 +0000 schrieb Paul Parsons:
> --- On Wed, 23/11/11, Dmitry Artamonow <mad_soft@inbox.ru> wrote:
> > BTW, it's funny that driver is placed in input/mouse, but
> > actually
> > reports only keyboard events :)
> > Anyway, reporting coordinates can be added at some later
> > point.
> 
> That's right, the underlying hardware is a touchpad so the driver could report mouse events if required. Obviously the hx4700 already has a working touchscreen so it's not obvious what benefit a second mouse device would add. And I'm not aware of any other platforms which use the NavPoint.

I agree, the NavPoint is pretty useless as a touchpad.

I think there's some kind of Logitech Wireless Keyboard / Remote that
has a NavPoint, but I'm not aware of anything with them that would run
linux either.

regards
Philipp
