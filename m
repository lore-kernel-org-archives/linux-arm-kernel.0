From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 1 May 2012 20:04:25 +0200
Subject: [PATCH] clk: Use a separate struct for holding init data.
In-Reply-To: <20120501170001.GB4089@opensource.wolfsonmicro.com>
References: <4F98EB10.2000505@codeaurora.org>
 <20120426084201.GF17184@pengutronix.de>
 <4d67387a86d99cbb4e2acf68d3588b1c.squirrel@www.codeaurora.org>
 <20120426095135.GG17184@pengutronix.de>
 <4F9EE84C.90106@codeaurora.org>
 <CAJOA=zNCagT6GaeHi_jq7-LU9P-SfJZ8PA9bo-oeswjC0tHyYA@mail.gmail.com>
 <4F9F1659.1010804@codeaurora.org>
 <20120501081103.GC2194@S2101-09.ap.freescale.net>
 <20120501091334.GG15541@lunn.ch>
 <20120501170001.GB4089@opensource.wolfsonmicro.com>
Message-ID: <20120501180425.GV25584@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Or merge the platforms then do framework changes incrementally, updating
> the platforms as we go (which is the normal pattern for maintaining a
> framework...).  I see we've already got SPEAr merged.

I'm not too sure SPEAr has been really merged. As far as i understand,
its dependencies have not been fulfilled, so it does not compile. This
to me is another indication of the problems we have at the moment...

   Andrew
