From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 1 May 2012 18:00:01 +0100
Subject: [PATCH] clk: Use a separate struct for holding init data.
In-Reply-To: <20120501091334.GG15541@lunn.ch>
References: <1335419936-10881-1-git-send-email-skannan@codeaurora.org>
 <4F98EB10.2000505@codeaurora.org>
 <20120426084201.GF17184@pengutronix.de>
 <4d67387a86d99cbb4e2acf68d3588b1c.squirrel@www.codeaurora.org>
 <20120426095135.GG17184@pengutronix.de>
 <4F9EE84C.90106@codeaurora.org>
 <CAJOA=zNCagT6GaeHi_jq7-LU9P-SfJZ8PA9bo-oeswjC0tHyYA@mail.gmail.com>
 <4F9F1659.1010804@codeaurora.org>
 <20120501081103.GC2194@S2101-09.ap.freescale.net>
 <20120501091334.GG15541@lunn.ch>
Message-ID: <20120501170001.GB4089@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2012 at 11:13:34AM +0200, Andrew Lunn wrote:

> I agree with you as well, it is frustrating. Could we agree, that once
> this patch is in, we freeze the core until the start of the next
> cycle. We use the remainder of this cycle for porting platforms to the
> generic clock framework.

Or merge the platforms then do framework changes incrementally, updating
the platforms as we go (which is the normal pattern for maintaining a
framework...).  I see we've already got SPEAr merged.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120501/f67b54b6/attachment.sig>
