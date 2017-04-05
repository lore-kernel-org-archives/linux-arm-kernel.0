From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 5 Apr 2017 13:18:57 +0200
Subject: [PATCH v6 17/39] platform: add video-multiplexer subdevice driver
In-Reply-To: <1490661656-10318-18-git-send-email-steve_longerbeam@mentor.com>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
 <1490661656-10318-18-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170405111857.GA26831@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> + * video stream multiplexer controlled via gpio or syscon
> + *
> + * Copyright (C) 2013 Pengutronix, Sascha Hauer <kernel@pengutronix.de>
> + * Copyright (C) 2016 Pengutronix, Philipp Zabel <kernel@pengutronix.de>

This is actually quite interesting. Same email address for two
people...

Plus, I believe this wants to say that copyright is with Pengutronix,
not Sascha and Philipp. In that case you probably want to list
copyright and authors separately?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170405/09cc8ef6/attachment.sig>
