From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 11:20:10 +0100
Subject: [RESEND][PATCH V2 0/2] Add a common macro for creating struct
	clk_lookup entries
In-Reply-To: <057301cc880c$cc7f1f50$657d5df0$%kim@samsung.com>
References: <1318333530-7023-1-git-send-email-padma.v@samsung.com>
	<057301cc880c$cc7f1f50$657d5df0$%kim@samsung.com>
Message-ID: <20111013102010.GQ21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2011 at 08:56:23PM +0900, Kukjin Kim wrote:
> Russell,
> Maybe as you know, this is required on upcoming Samsung stuff. Actually it's
> just change/consolidate on other stuff but add on Samsung stuff. So if
> you're ok, how about sending this to upstream via arm-soc or your tree in
> this merge window?

I think taking the first patch is the right thing before the merge
window opens, because that's the one which everything else will depend
upon.

The second patch probably needs splitting up between the various SoCs
and either submitted to their maintainers or to Arnd after the merge
window has closed.

I suspect that we're looking at one of:
a) a matter of days to the merge window opening - though the timing of
   it (9 days before the kernel summit) doesn't look good, unless it's
   going to be a short window.
b) -rc9 will persist for the next fortnight
c) we'll see the first 3.x-rc10 kernel.
