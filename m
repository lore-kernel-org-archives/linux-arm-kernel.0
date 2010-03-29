From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 29 Mar 2010 22:50:59 +0100
Subject: [GIT PULL] generic arm for MSM try2
In-Reply-To: <1269894478.17124.32.camel@c-dwalke-linux.qualcomm.com>
References: <1269560155.21793.89.camel@c-dwalke-linux.qualcomm.com>
	<20100328214901.GA8614@n2100.arm.linux.org.uk>
	<1269881777.17124.5.camel@c-dwalke-linux.qualcomm.com>
	<20100329172841.GD28468@n2100.arm.linux.org.uk>
	<1269894478.17124.32.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <1269899459.2038.22.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-03-29 at 21:27 +0100, Daniel Walker wrote:
> On Mon, 2010-03-29 at 18:28 +0100, Russell King - ARM Linux wrote:
> > Catalin, as the apparant author of this file, do you have a view on this?
> 
> Looking at this file again, I don't think anyone could copyright
> anything in this file prior to us adding stuff .. It's like 4 lines of
> assembly prior to us adding 13 lines ..

I don't think the amount of lines matter wrt GPL. I agree that the
existing 4 lines aren't anything important but if you consider them as
part of a bigger patch (commit bbe88886), they are not so insignificant.
I don't care much about these four lines, it's just a matter of
principle.

If you want, you can add something like (the GPL preamble is fine):

 * ...
 * Copyright (C) 2007 ARM Ltd.
 * Copyright (C) 2010 Code Aurora Forum.

The reason why I haven't added a header is because this file was most
likely derived from abort-ev6.S (probably originating from Deep Blue
Solutions - that's the "..." part above).

Personally, I wouldn't bother with adding a copyright header for 13
lines but your legal department may have a different view.

Note - that's my personal view only, the copyright of the work I produce
belongs to ARM Ltd.

-- 
Catalin
