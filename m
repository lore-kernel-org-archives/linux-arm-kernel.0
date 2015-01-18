From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 18 Jan 2015 22:02:17 +0100
Subject: [PATCH 0/4] Drop legacy support for omap3517
In-Reply-To: <201501132150.56938@pali>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
 <10549142.7lWnPtPtZG@wuerfel> <20150113204219.GJ2419@atomide.com>
 <201501132150.56938@pali>
Message-ID: <20150118210217.GB31807@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> CCing Pavel Machek
> 
> He reported also some (still not fixed) regressions on n900.

adp1653 flash driver does not have device tree bindings, yet. Patches
were submitted, but I guess I'll need to push them some more.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
