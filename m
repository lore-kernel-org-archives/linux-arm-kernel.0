From: holler@ahsoftware.de (Alexander Holler)
Date: Fri, 08 Apr 2011 01:04:01 +0200
Subject: [PATCH 1/2] ARM: Differentiate SheevaPlugs and DockStars on	the
	basis of the memory size.
In-Reply-To: <20110407220855.GD17049@n2100.arm.linux.org.uk>
References: <1302122121-3652-1-git-send-email-holler@ahsoftware.de>
	<1302122121-3652-2-git-send-email-holler@ahsoftware.de>
	<alpine.LFD.2.00.1104061739100.28032@xanadu.home>
	<4D9CED15.2010806@ahsoftware.de>
	<alpine.LFD.2.00.1104061850410.28032@xanadu.home>
	<4D9CF5B3.9020007@ahsoftware.de>
	<toa078-0do.ln1@chipmunk.wormnet.eu>
	<4D9E2D1C.7070102@ahsoftware.de>
	<20110407220855.GD17049@n2100.arm.linux.org.uk>
Message-ID: <4D9E42E1.1060902@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 08.04.2011 00:08, schrieb Russell King - ARM Linux:

>> Requiring a machine ID and the needed stuff to handle that for a board
>> which just is using two GPIOs different than another board is why the
>> ARM tree exploded.
>
> You can not be any more wrong than that.
>
> The reason the ARM tree exploded is because of the compartmentalized
> sub-community structure, where the vast majority of (eg) OMAP development
> is done independently of the (eg) Samsung development.
>
> Consequently, there's no attempt to consolidate code between the SoCs,
> even for basic stuff like 32-bit up-counting timers.  We've ended up with
> _nine_ implementations of clocksources all doing the same thing in that
> respect.
>
> That's got precisely zilch to do with machine IDs, and your attempt to
> blame the bloat on machine IDs just shows how misinformed you are.

I had a look at what's going on in the OMAP linux world for more than a 
year now and I think I've seen a lot of the stuff you are referring to.

And I think one of the reasons that the mess happened is the same I've 
got trapped in. Why should anyone try to submit patches if he must fear 
to get caught in some senseless endless discussion about one line.

E.g. requiring people to use NULL than 0 or that stupid discussion now 
about the simple patch I've posted. I'm writing whole (readable) C++ 
applications (not crap!) in less time than what's is needed to submit 
and discuss a small patch for some silly hw.

So for me it's fully understandable why companies don't try to work with 
kernel people at first. They try to develop innovativ products they can 
sell, and it doesn't help if their developers would have to fear that 
they get called stupid, crap and abonimation writing aliens for things 
like the small patch I've posted, which in turn requires them to defend 
them against those people doing so (which ends in such stupid 
discussions like this).

It's one thing to say such to someone you know and work with, but it's a 
totally different thing to say such to someone you almost know nothing 
about. And not everybody who hasn't the name of a big company in his 
email address is a moron.

Sorry, I'm getting sick having to defend me here against people who like 
to call others crap and abonimation writing ones just because they have 
maintainer status or whatever.

Regards,

Alexander
