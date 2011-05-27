From: khilman@ti.com (Kevin Hilman)
Date: Fri, 27 May 2011 13:51:58 -0700
Subject: [PATCH] ARM: OMAP: Get rid of section mismatch warnings
In-Reply-To: <20110527105414.GE27962@atomide.com> (Tony Lindgren's message of
	"Fri, 27 May 2011 13:54:15 +0300")
References: <1306414838-4330-1-git-send-email-silesh@ti.com>
	<4DDE4EEF.8070108@ti.com> <20110526133732.GD11352@atomide.com>
	<20110526135533.GA25841@n2100.arm.linux.org.uk>
	<20110527105414.GE27962@atomide.com>
Message-ID: <877h9byihd.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110526 16:51]:
>> On Thu, May 26, 2011 at 06:37:32AM -0700, Tony Lindgren wrote:
>> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [110526 05:56]:
>> > > On 5/26/2011 6:30 PM, Silesh C V wrote:
>> > > >Get rid of the following and 8 other similar section mismatch
>> > > >warnings
>> > > >
>> > > I send this [1] patch a month back. It's still not considered
>> > > though even after reminder.
>> > > 
>> > > [1] https://patchwork.kernel.org/patch/684831/
>> > 
>> > Applying now into devel-fixes with additional fixes from Silesh.
>> > Updated patch below.
>> 
>> I also have this from a while back.  There's also some nastyness in
>> twl4030-power.c which requires basically s/__init/__devinit/ to almost
>> the entire file.
>
> OK thanks. Kevin, can you queue this fix? Assuming the move of omap
> gpio to drivers/gpio happens this merge window, this needs to be
> updated for the path.

Yeah, I'll take care of this.

GPIO move is now merged for 2.6.40, so I'll queue this as a fix for
the first -rc cycle.

Kevin
