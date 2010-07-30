From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Jul 2010 21:20:29 +0100
Subject: [PATCH 2/3] arm: mm: do not set missing flags on ScorpionMP
In-Reply-To: <1280509777.4142.3.camel@m0nster>
References: <1279911483-7039-1-git-send-email-johlstei@codeaurora.org>
	<1279911483-7039-3-git-send-email-johlstei@codeaurora.org>
	<20100724082334.GB15571@n2100.arm.linux.org.uk>
	<1280354280.21185.10.camel@c-dwalke-linux.qualcomm.com>
	<20100728223603.GB6729@n2100.arm.linux.org.uk>
	<1280357495.21185.26.camel@c-dwalke-linux.qualcomm.com>
	<20100729071818.GC6729@n2100.arm.linux.org.uk>
	<1280443366.27035.14.camel@c-dwalke-linux.qualcomm.com>
	<20100730071910.GC29746@n2100.arm.linux.org.uk>
	<1280509777.4142.3.camel@m0nster>
Message-ID: <20100730202029.GB15062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 30, 2010 at 10:09:37AM -0700, Daniel Walker wrote:
> On Fri, 2010-07-30 at 08:19 +0100, Russell King - ARM Linux wrote:
> > Yes, but if its just for this patch, is there much point to a pull
> > request?
> 
> I've got some other stuff too .. Jeff Ohlstein sent several patches (one
> of which started this discussion), which are needed for an SMP board
> we've been working on.

Has it been seen on the mailing list?
