From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 05 Apr 2017 13:58:39 +0200
Subject: [PATCH v6 17/39] platform: add video-multiplexer subdevice driver
In-Reply-To: <20170405111857.GA26831@amd>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
 <1490661656-10318-18-git-send-email-steve_longerbeam@mentor.com>
 <20170405111857.GA26831@amd>
Message-ID: <1491393519.2904.40.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 05.04.2017, 13:18 +0200 schrieb Pavel Machek:
> Hi!
> 
> > + * video stream multiplexer controlled via gpio or syscon
> > + *
> > + * Copyright (C) 2013 Pengutronix, Sascha Hauer <kernel@pengutronix.de>
> > + * Copyright (C) 2016 Pengutronix, Philipp Zabel <kernel@pengutronix.de>
> 
> This is actually quite interesting. Same email address for two
> people...
> 
> Plus, I believe this wants to say that copyright is with Pengutronix,
> not Sascha and Philipp. In that case you probably want to list
> copyright and authors separately?
> 
Nope, copyright doesn't get transferred to the employer within the rules
of the German "Urheberrecht", but stays at the original author of the
code.
Same email is just to ensure that any requests regarding this code get
routed to the right people, even if someone leaves the company or is
temporarily unavailable. kernel@ is a list for the Pengutronix kernel
team.

Regards,
Lucas
