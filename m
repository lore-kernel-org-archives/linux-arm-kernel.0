From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Oct 2009 17:41:23 +0100
Subject: RMK's sa1100 branch (was Re: [PATCH 2/9] collie: prepare for
	gpiolib use)
In-Reply-To: <20091007143351.GA10769@rainbow>
References: <1254778533-3529-1-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-2-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-3-git-send-email-thommycheck@gmx.de>
	<20091007110805.GA7656@rainbow>
	<20091007112552.GC6246@n2100.arm.linux.org.uk>
	<20091007124251.GB7656@rainbow>
	<20091007131003.GA11371@n2100.arm.linux.org.uk>
	<20091007143351.GA10769@rainbow>
Message-ID: <20091007164123.GC11371@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2009 at 06:33:51PM +0400, Dmitry Artamonow wrote:
> On 14:10 Wed 07 Oct     , Russell King - ARM Linux wrote:
> > On Wed, Oct 07, 2009 at 04:42:52PM +0400, Dmitry Artamonow wrote:
> > I tinkered around with this yesterday before your message came through,
> > and I defined a new set of definitions, eg:
> > 
> > #define H3100_GPIO_IR_ON	8
> > 
> > so avoiding the problem.  See my 'sa1100' branch published in the usual
> > places.
> 
> Whoa! Seems that you did a lot of work. What do you plan to do with it?
> Should I rebase my work on top of IPAQ patches in this branch?

That's up to you really - while I do have a H3600 which had Linux on,
I don't know what state it's in with regard to being usable, so I
don't count myself as being able to properly test changes in this
area.
