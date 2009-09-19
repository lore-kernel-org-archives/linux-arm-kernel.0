From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 19 Sep 2009 15:47:31 +0200
Subject: [PATCH v4] arm: remove unused code in delay.S
In-Reply-To: <1253364929.3273.298.camel@linux-1lbu>
References: <1253292418.3273.257.camel@linux-1lbu>
	<20090918190920.GB11461@pengutronix.de>
	<1253305534.3273.283.camel@linux-1lbu>
	<20090918205349.GM29905@game.jcrosoft.org>
	<1253364929.3273.298.camel@linux-1lbu>
Message-ID: <20090919134731.GA11231@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Steve,

On Sat, Sep 19, 2009 at 07:55:29AM -0500, Steve Chen wrote:
> Document #if 0 code block in delay.S and make it selectable for compile.
> 
> Signed-off-by: Steve Chen <schen@mvista.com>
> Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>
> Reviewed-by: Jamie Lokier <jamie@shareable.org>
> Reviewed-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Reviewed-by: Krzysztof Halasa <khc@pm.waw.pl>
> Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
> Reviewed-by: Pavel Machek <pavel@ucw.cz>
> Reviewed-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Reviewed-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
I'm very surprised you added these Reviewed-by: tags.

IMO you should not add them without the explicit permission and request
of the corresponding person.  (That means that at least mine should not
be there.)

Moreover Reviewed-by: has a meaning (described in
Documentation/SubmittingPatches).

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
