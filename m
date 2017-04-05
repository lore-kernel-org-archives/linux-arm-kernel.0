From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 5 Apr 2017 20:05:00 +0200
Subject: [PATCH v6 17/39] platform: add video-multiplexer subdevice driver
In-Reply-To: <1491393519.2904.40.camel@pengutronix.de>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
 <1490661656-10318-18-git-send-email-steve_longerbeam@mentor.com>
 <20170405111857.GA26831@amd>
 <1491393519.2904.40.camel@pengutronix.de>
Message-ID: <20170405180500.GA30408@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2017-04-05 13:58:39, Lucas Stach wrote:
> Am Mittwoch, den 05.04.2017, 13:18 +0200 schrieb Pavel Machek:
> > Hi!
> > 
> > > + * video stream multiplexer controlled via gpio or syscon
> > > + *
> > > + * Copyright (C) 2013 Pengutronix, Sascha Hauer <kernel@pengutronix.de>
> > > + * Copyright (C) 2016 Pengutronix, Philipp Zabel <kernel@pengutronix.de>
> > 
> > This is actually quite interesting. Same email address for two
> > people...
> > 
> > Plus, I believe this wants to say that copyright is with Pengutronix,
> > not Sascha and Philipp. In that case you probably want to list
> > copyright and authors separately?
> > 
> Nope, copyright doesn't get transferred to the employer within the rules
> of the German "Urheberrecht", but stays at the original author of the
> code.

Ok, then I guess it should be

Copyright (C) 2013 Sascha Hauer
Work sponsored by Pengutronix, use <kernel@pengutronix.de> as contact address

or something? I know license change is not on the table, but I guess
it is good to get legal stuff right.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170405/ebfb44c4/attachment.sig>
