From: tbm@cyrius.com (Martin Michlmayr)
Date: Fri, 16 Jul 2010 10:37:44 +0100
Subject: [PATCH] Stop ARM boards crashing when CUPS is loaded - 2.6.35-rc5
In-Reply-To: <4C40218A.4090806@canonical.com>
References: <4C3C72C6.4000005@canonical.com>
	<20100715130214.4c9303b2.akpm@linux-foundation.org>
	<20100715200618.GA6773@n2100.arm.linux.org.uk>
	<4C40218A.4090806@canonical.com>
Message-ID: <20100716093744.GN11238@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lee Jones <lee.jones@canonical.com> [2010-07-16 10:08]:
> >> That sounds like a pretty serious problem.  But presumably it isn't -
> >> otherwise it would have been fixed earlier!
> 
> Well it is a problem on OMAP based boards.

It's not just OMAP.  Debian received a similar bug report a few days
too and it was on Marvell Orion hardware.  I simply disabled the
parport_pc module on ARM.

-- 
Martin Michlmayr
http://www.cyrius.com/
