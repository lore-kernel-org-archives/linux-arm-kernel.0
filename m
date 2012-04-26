From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Thu, 26 Apr 2012 16:21:26 +0200
Subject: [PATCH 31/33] ARM i.MX5: implement clocks using common clock
 framework
In-Reply-To: <20120426130222.GI17184@pengutronix.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
 <201204261448.00925.heiko@sntech.de> <20120426130222.GI17184@pengutronix.de>
Message-ID: <201204261621.27142.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 26. April 2012, 15:02:22 schrieb Sascha Hauer:
> On Thu, Apr 26, 2012 at 02:48:00PM +0200, Heiko St?bner wrote:
> > Hi Sascha,
> > 
> > more out of curiosity, why is the i.MX50 always excluded. Is it so vastly
> > different to the MX51 and MX53?
> 
> I don't think that it's so different. I think the reason is that the
> i.MX50 is not widely used outside of some special applications. At least
> we have no customers using it.

yeah, I started working on one of those "special applications" :-) .Currently 
based on the freescale tree, where the mx50 seems to have its own clock file. 

So, it seems I'll take a look myself to see what is missing/different.


Heiko
