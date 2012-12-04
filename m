From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Tue, 4 Dec 2012 22:32:32 +0100
Subject: [PATCH v2] ARM: eukrea_mbimx27-baseboard - use stock
 get_pendown_state() in ads7846
In-Reply-To: <20121204210922.GA8620@core.coreip.homeip.net>
References: <20121124082529.GA7687@core.coreip.homeip.net>
 <20121127074209.GL10369@pengutronix.de>
 <20121127090356.GA25658@core.coreip.homeip.net>
 <20121204210922.GA8620@core.coreip.homeip.net>
Message-ID: <20121204223232.700787a1@eb-e6520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 4 Dec 2012 13:09:22 -0800,
Dmitry Torokhov <dmitry.torokhov@gmail.com> a ?crit :

> On Tue, Nov 27, 2012 at 01:03:56AM -0800, Dmitry Torokhov wrote:
> > The default implementation matches exactly our custom one so we can switch
> > to using the default one. As a bonus the driver will take care of setting
> > GPIO line for us.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Eric, Sascha, could I get a formal ack on this one please ?
> 
Acked-by: Eric B?nard <eric@eukrea.com>
