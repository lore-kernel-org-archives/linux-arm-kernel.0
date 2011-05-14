From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 14 May 2011 20:40:17 +0100
Subject: [PATCH 06/14] mfd: pxa-w1: MFD driver for PXA 1wire control +
	DS1WM chip
In-Reply-To: <BANLkTinpFBfOEOR6Ox1ufEHZo3qwRq8zhA@mail.gmail.com>
References: <1303135451-26362-7-git-send-email-haojian.zhuang@marvell.com>
	<20110426094836.GD2659@sortiz-mobl>
	<BANLkTinpFBfOEOR6Ox1ufEHZo3qwRq8zhA@mail.gmail.com>
Message-ID: <20110514194017.GF30539@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 14, 2011 at 10:21:25PM +0800, Haojian Zhuang wrote:
> But the key issue is that there's no common structure for clkdev. Now
> clkdev is only designed for deeply machine depend.
> 
> >From my view is that we need a common structure for clkdev.

You mean struct clk.

As I said on our call on Thursday, everyone knows this, and it's
something that has been worked on for the last year.  Concensus had
been reached and everyone had settled on a proposal, and just when
we were almost ready to merge it, the concensus fell apart again.

As a result of that, a common struct clk has been delayed - it's not
going to be in place for 2.6.40 (three months) but maybe we can reach
concensus again for the .41 merge window.

As I also said, this issue was talked about in a session at the Linaro
conference, and it will be interesting to hear what the result of that
session was.  At the moment, I'm entirely out of the loop on many things
that were discussed there (except for a message from tglx.)
