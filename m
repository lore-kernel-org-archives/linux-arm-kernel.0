From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 29 Mar 2010 15:10:34 -0700
Subject: [GIT PULL] generic arm for MSM try2
In-Reply-To: <1269899459.2038.22.camel@e102109-lin.cambridge.arm.com>
References: <1269560155.21793.89.camel@c-dwalke-linux.qualcomm.com>
	<20100328214901.GA8614@n2100.arm.linux.org.uk>
	<1269881777.17124.5.camel@c-dwalke-linux.qualcomm.com>
	<20100329172841.GD28468@n2100.arm.linux.org.uk>
	<1269894478.17124.32.camel@c-dwalke-linux.qualcomm.com>
	<1269899459.2038.22.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1269900634.17124.34.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-03-29 at 22:50 +0100, Catalin Marinas wrote:
> On Mon, 2010-03-29 at 21:27 +0100, Daniel Walker wrote:
> > On Mon, 2010-03-29 at 18:28 +0100, Russell King - ARM Linux wrote:
> > > Catalin, as the apparant author of this file, do you have a view on this?
> > 
> > Looking at this file again, I don't think anyone could copyright
> > anything in this file prior to us adding stuff .. It's like 4 lines of
> > assembly prior to us adding 13 lines ..
> 
> I don't think the amount of lines matter wrt GPL. I agree that the
> existing 4 lines aren't anything important but if you consider them as
> part of a bigger patch (commit bbe88886), they are not so insignificant.
> I don't care much about these four lines, it's just a matter of
> principle.
> 
> If you want, you can add something like (the GPL preamble is fine):
> 
>  * ...
>  * Copyright (C) 2007 ARM Ltd.
>  * Copyright (C) 2010 Code Aurora Forum.
> 
> The reason why I haven't added a header is because this file was most
> likely derived from abort-ev6.S (probably originating from Deep Blue
> Solutions - that's the "..." part above).

I were to add this what would I add for the "..." since there's nothing
in abort-ev6.S either.. None of the abort files appear to have
copyrights.

Daniel
