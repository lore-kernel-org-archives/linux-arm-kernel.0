From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Nov 2016 18:41:07 +0000
Subject: [PATCH/RESEND] recordmcount: arm: Implement make_nop
In-Reply-To: <20161114133641.09b1abfb@gandalf.local.home>
References: <20161018234200.5804-1-sboyd@codeaurora.org>
 <20161018200707.36e549ee@gandalf.local.home>
 <20161114133641.09b1abfb@gandalf.local.home>
Message-ID: <20161114184106.GR1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 01:36:41PM -0500, Steven Rostedt wrote:
> On Tue, 18 Oct 2016 20:07:07 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 18 Oct 2016 16:42:00 -0700
> > Stephen Boyd <sboyd@codeaurora.org> wrote:
> > 
> > > In similar spirit to x86 and arm64 support, add a make_nop_arm()
> > > to replace calls to mcount with a nop in sections that aren't
> > > traced.
> > > 
> > > Cc: Russell King <linux@arm.linux.org.uk>
> > > Acked-by: Rabin Vincent <rabin@rab.in>
> > > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>  
> > 
> > I can take this if I can get an ack from the ARM maintainers.
> 
> Any ARM maintainer want to ack this, or take it in their tree if they
> haven't already?

Assuming it's been tested:

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
