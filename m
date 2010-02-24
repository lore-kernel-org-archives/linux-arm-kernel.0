From: hector@marcansoft.com (Hector Martin)
Date: Wed, 24 Feb 2010 23:09:13 +0100
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <20100224153028.GA28805@pengutronix.de>
References: <1266933437-4876-1-git-send-email-hector@marcansoft.com>	<20100224084259.GA8068@pengutronix.de>	<4B84F0F6.40902@marcansoft.com>	<20100224110353.GA15105@n2100.arm.linux.org.uk>	<4B8543B2.4030004@marcansoft.com>
	<20100224153028.GA28805@pengutronix.de>
Message-ID: <4B85A389.6080701@marcansoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig wrote:
> Independant of the outcome of this discussion I suggest reverting the
> switch to the new decompressor for .33.  Hectors patch definitely isn't
> .33 material and broken or not the old decompressor was more reliable.

That's reasonable, as far as .33 goes. Obviously I'm not expecting my
patch to make it to this release.

-- 
Hector Martin (hector at marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc
