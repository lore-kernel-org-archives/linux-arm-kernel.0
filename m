From: schen@mvista.com (Steve Chen)
Date: Sat, 19 Sep 2009 09:09:48 -0500
Subject: [PATCH v4] arm: remove unused code in delay.S
In-Reply-To: <20090919134731.GA11231@pengutronix.de>
References: <1253292418.3273.257.camel@linux-1lbu>
	<20090918190920.GB11461@pengutronix.de>
	<1253305534.3273.283.camel@linux-1lbu>
	<20090918205349.GM29905@game.jcrosoft.org>
	<1253364929.3273.298.camel@linux-1lbu>
	<20090919134731.GA11231@pengutronix.de>
Message-ID: <1253369389.3273.304.camel@linux-1lbu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2009-09-19 at 15:47 +0200, Uwe Kleine-K?nig wrote:
> Hello Steve,
> 
> On Sat, Sep 19, 2009 at 07:55:29AM -0500, Steve Chen wrote:
> > Document #if 0 code block in delay.S and make it selectable for compile.
> > 
> > Signed-off-by: Steve Chen <schen@mvista.com>
> > Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>
> > Reviewed-by: Jamie Lokier <jamie@shareable.org>
> > Reviewed-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Reviewed-by: Krzysztof Halasa <khc@pm.waw.pl>
> > Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
> > Reviewed-by: Pavel Machek <pavel@ucw.cz>
> > Reviewed-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> > Reviewed-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> I'm very surprised you added these Reviewed-by: tags.
> 
> IMO you should not add them without the explicit permission and request
> of the corresponding person.  (That means that at least mine should not
> be there.)
> 
> Moreover Reviewed-by: has a meaning (described in
> Documentation/SubmittingPatches).
> 

My only intention was to give credit to all who contributed (at least try).  I already
sent out a patch with all Reviewed-by tags removed.  I can add back in anyone who wish
to be added.

Regards,

Steve
