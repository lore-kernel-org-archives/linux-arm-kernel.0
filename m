From: rabin@rab.in (Rabin Vincent)
Date: Sun, 14 Feb 2010 01:24:44 +0530
Subject: [PATCH 2/2] ftrace: re-enable dynamic ftrace for ARM
In-Reply-To: <20100201211101.GB26532@pengutronix.de>
References: <1264959196-5175-1-git-send-email-rabin@rab.in>
	<1264959196-5175-2-git-send-email-rabin@rab.in>
	<20100201102843.GA31714@pengutronix.de>
	<20100201165318.GA1846@debian>
	<20100201211101.GB26532@pengutronix.de>
Message-ID: <20100213195444.GA31190@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2010 at 10:11:02PM +0100, Uwe Kleine-K?nig wrote:
> That's OK for me.  Then the only thing that would be nice would be some
> more documentation.  E.g. how looks the function prologue in the two
> cases, which of these instruction is patched?
> 
> This doesn't need to be a stopper for your patch, it's on my long term
> todo list already to add some documentation to the (non-dynamic) ftrace
> on arm.  I wouldn't mind to add the documentation myself, but not now.

I've add this documentation (among other things) in the updated patch
set I've just posted.

Rabin
