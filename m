From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 19 Jan 2010 09:38:03 +0100
Subject: make PHYS_OFFSET determined at run time (unfinished)
Message-ID: <20100119083803.GA17904@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm looking into making PHYS_OFFSET determined at run time.  I saw a
patch for it that already made it a few times on the list[1].

I'm not yet done, but first want to announce that I look into that to
prevent duplicate work---so if you intended to do the same let's look
together---and to post some clean up patches that are the result up to
now of my digging in the boot code.

I will send now three patches in reply to this mail, and later hopefully
more.

Best regards
Uwe

[1] e.g. http://thread.gmane.org/gmane.linux.ports.arm.kernel/53793/

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
