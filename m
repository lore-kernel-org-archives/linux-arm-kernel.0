From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 4 Mar 2011 20:46:16 +0100
Subject: [PATCH] ARM: mx51_efika: update platform data for new mfd changes
In-Reply-To: <20110304083822.0f40d120@debxo>
References: <20110304080653.3f2c3f19@debxo> <4D710FF9.6040305@ru.mvista.com>
	<20110304083822.0f40d120@debxo>
Message-ID: <20110304194616.GW22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2011 at 08:38:22AM -0800, Andres Salomon wrote:
> On Fri, 04 Mar 2011 19:14:49 +0300
> Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> 
> > Hello.
> > 
> > Andres Salomon wrote:
> > 
> > > Note that this relies on stuff currently in mfd's next tree, but
> > > this is also a newer driver.  I'm not sure which tree it should go
> > > through, as it's a problem that shows up in next.
> > 
> >     This passage should be under --- tear line.
> 
> What?
Actually putting it above the commit log and separating it by a scissors
line (see git-mailinfo(1), git am -c) should be fine, too.

This is all about selecting which part of the message should end up in
the commit log.  Git ignores everything after the tripple dash (apart
from the patch of course).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
