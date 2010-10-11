From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Oct 2010 11:15:04 +0100
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <AANLkTikYRfK-KHYxPL5y4z7kbb0YVn2y0CiYiMvWDsB-@mail.gmail.com>
References: <20101008230451.GB10975@n2100.arm.linux.org.uk>
	<20101008232539.GA28697@kroah.com>
	<20101008234448.GD10975@n2100.arm.linux.org.uk>
	<AANLkTinhwORqdWU43yr1AXJGZm2zPKGG+Q9twruNs2aH@mail.gmail.com>
	<20101009092127.GB20975@n2100.arm.linux.org.uk>
	<AANLkTimQJLmDZPHtVJLCv9ZQgx_Yjh9=MOwOxMSAz4QX@mail.gmail.com>
	<20101011083508.GW29673@pengutronix.de>
	<20101011090212.GA27153@n2100.arm.linux.org.uk>
	<20101011092424.GX29673@pengutronix.de>
	<AANLkTikYRfK-KHYxPL5y4z7kbb0YVn2y0CiYiMvWDsB-@mail.gmail.com>
Message-ID: <20101011101504.GC27153@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 01:08:29PM +0300, Felipe Contreras wrote:
> So, coming back to the arguments. I think Russell should have tried
> this and provided an example of what to do, and how. I think it should
> be clear by now that there's not much known affected drivers can do
> right now.

Those people who have stupid platforms that require major chunks of
memory should have been paying attention and evaluated the patch six
months ago.

They partly did that, and asked some questions about how to solve it.
They got answers, and then nothing happened.  And it's somehow my
problem that they did nothing?

*They* should have done more to help instead of ignoring the issue,
then we'd know where things were _before_ the patch was originally
merged.

Not my problem.
