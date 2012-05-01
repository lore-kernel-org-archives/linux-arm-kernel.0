From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 1 May 2012 11:13:34 +0200
Subject: [PATCH] clk: Use a separate struct for holding init data.
In-Reply-To: <20120501081103.GC2194@S2101-09.ap.freescale.net>
References: <1335419936-10881-1-git-send-email-skannan@codeaurora.org>
 <4F98EB10.2000505@codeaurora.org>
 <20120426084201.GF17184@pengutronix.de>
 <4d67387a86d99cbb4e2acf68d3588b1c.squirrel@www.codeaurora.org>
 <20120426095135.GG17184@pengutronix.de>
 <4F9EE84C.90106@codeaurora.org>
 <CAJOA=zNCagT6GaeHi_jq7-LU9P-SfJZ8PA9bo-oeswjC0tHyYA@mail.gmail.com>
 <4F9F1659.1010804@codeaurora.org>
 <20120501081103.GC2194@S2101-09.ap.freescale.net>
Message-ID: <20120501091334.GG15541@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2012 at 04:11:05PM +0800, Shawn Guo wrote:
> On Mon, Apr 30, 2012 at 03:46:49PM -0700, Saravana Kannan wrote:
> > I'm still hoping a Ack/Nack for the general idea from the others.
> > 
> I believe that I have Acked the idea when you proposed it at the first
> time.  What I really hoped is you can post the patch at least 1 week
> earlier.  Basically I share the same frustration that Sascha has, the
> platform porting have been delayed by flowing changes on the core code.
> It's been -rc5, but we have not got a stable core base to have platform
> porting expose on linux-next.

Hi folks

I agree with you as well, it is frustrating. Could we agree, that once
this patch is in, we freeze the core until the start of the next
cycle. We use the remainder of this cycle for porting platforms to the
generic clock framework.

	  Andrew
