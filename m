From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 17:22:44 +0000
Subject: [PATCH 0/2] ARM: Gemini: add RTC support for Gemini SoC
In-Reply-To: <20110119110754.GB31652@n2100.arm.linux.org.uk>
References: <1292339307-14336-1-git-send-email-ulli.kroll@googlemail.com>
	<20110107093155.GN31708@n2100.arm.linux.org.uk>
	<20110119110754.GB31652@n2100.arm.linux.org.uk>
Message-ID: <20110124172244.GJ24104@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 11:07:54AM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 07, 2011 at 09:31:55AM +0000, Russell King - ARM Linux wrote:
> > On Tue, Dec 14, 2010 at 04:08:25PM +0100, Hans Ulli Kroll wrote:
> > > This patch adds the driver for the rtc chip on the Gemini SoC
> > 
> > I'll take patch 2, but not patch 1.  There is no requirement for patch 1
> > to come via my tree - it can be handled by the RTC people.
> > 
> > My tree is not for random driver code being merged into mainline just
> > because it's used on some ARM platform somewhere.
> > 
> > (I'm making this request as a result of feedback from Linus on last nights
> > merge of the ARM tree.)
> 
> What's the status of patch 1 wrt the RTC folk?

So... complete silence.

I'll take the ARM specific patch but you'll have to find some other way
to get the drivers/rtc part in.
