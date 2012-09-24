From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 24 Sep 2012 18:24:21 +0100
Subject: [PATCH v4] hwmon: Versatile Express hwmon driver
In-Reply-To: <20120924171817.GA29274@roeck-us.net>
References: <1348246591-2409-1-git-send-email-mail@pawelmoll.com>
 <20120924155947.GA14060@roeck-us.net> <1348502972.27071.16.camel@hornet>
 <20120924171817.GA29274@roeck-us.net>
Message-ID: <1348507461.27071.22.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-09-24 at 18:18 +0100, Guenter Roeck wrote:
> > I was planning to push the subsystem patches (hwmon, regulator etc.)
> > through respective maintainers, so through your tree - the driver
> > depends on VEXPRESS_CONFIG so won't cause any build issues before the
> > infrastructure is in place. Of course if you'd rather see it go through
> > arm-soc, I'll add it to that branch. Just let me know what is your
> > preference.
> > 
> Since the driver can not be built w/o the rest of the infrastructure,
> I think it should be pushed through a tree where it can. This way we also
> make sure that it is in sync with its infrastructure, and avoid bad surprises
> late in the game.

No problem, thanks again for your time!

Pawe?
