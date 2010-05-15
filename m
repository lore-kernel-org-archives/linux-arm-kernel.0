From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 May 2010 11:11:18 +0100
Subject: [PATCH] mx21/devices: fix USBOTG resource
In-Reply-To: <1273889324-29720-1-git-send-email-w.sang@pengutronix.de>
References: <1273889324-29720-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20100515101118.GB17080@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 15, 2010 at 04:08:44AM +0200, Wolfram Sang wrote:
> It got a typo from 988addf82e4c03739375279de73929580a2d4a6a.

It's one of the problems of git rerere - although it remembers the
resolution, if it's the wrong resolution there's no easy way to get
it to drop the wrong one in favour of a corrected one, short of
blowing away the entire .git/rr-cache directory.

I've got one such instance with the AT91 stuff at the moment, where
a patch has been submitted which breaks the AT91 USB code...

However, please send your patch to the patch system.
