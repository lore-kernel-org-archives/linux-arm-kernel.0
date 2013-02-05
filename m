From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 05 Feb 2013 20:11:41 +0100
Subject: [GIT PULL] i.MX clock fixes for v3.8
In-Reply-To: <20130205184419.GA21776@quad.lixom.net>
References: <20130205095844.GZ1906@pengutronix.de>
 <20130205132759.GA17833@n2100.arm.linux.org.uk>
 <20130205184419.GA21776@quad.lixom.net>
Message-ID: <1483921.KfgYYkpMhJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 February 2013 10:44:19 Olof Johansson wrote:
> 
> Yeah, I was just looking at my queue here (and then came upon this thread).
> From what we have queued up right now in arm-soc fixes, I don't see anything
> that _truly_ needs to go in for 3.8.
> 
> If someone feels differently, let me know (with a very solid motivation) and
> I will consider sending it up. But right now I am likely going to fold the
> 'fixes' branch into 'fixes-non-critical' for 3.9 instead.

I was going to put the Samsung fixes for the new bintutils in, but I suppose
that can wait until 3.9, given that it has always been broken. Probably
-stable material though.

	Arnd
