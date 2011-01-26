From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Jan 2011 09:24:14 +0000
Subject: [PATCH] ARM: add PrimeCell generic DMA to MMCI/PL180
In-Reply-To: <AANLkTi=kMnXm+VU2V8HR98DhL1wVk6cJJQ0DtkV=yFqs@mail.gmail.com>
References: <1286358159-6994-1-git-send-email-linus.walleij@stericsson.com>
	<20101219163240.GA27929@n2100.arm.linux.org.uk>
	<20101219195959.GA28157@n2100.arm.linux.org.uk>
	<20101221135421.GS28157@n2100.arm.linux.org.uk>
	<20101221155935.GV28157@n2100.arm.linux.org.uk>
	<AANLkTin2fBLsq2YJHjZ=e+gmwWXWezH0t38bzsjiJ+i=@mail.gmail.com>
	<20110124160127.GA24104@n2100.arm.linux.org.uk>
	<AANLkTi=GmYoDYhKGpvzt2vHWSEb2b72cQbQfVc4PANdH@mail.gmail.com>
	<20110124212228.GN24104@n2100.arm.linux.org.uk>
	<AANLkTi=kMnXm+VU2V8HR98DhL1wVk6cJJQ0DtkV=yFqs@mail.gmail.com>
Message-ID: <20110126092414.GA2562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 09:33:07AM +0100, Linus Walleij wrote:
> In any case I'm happy if you post/commit the MMCI support
> you have, if there are problems we can certainly sort it out later
> in any case.
> 
> Hm, does this mean you got it working with one of the
> reference boards eventually?

Nope.  ARM reference boards all seem to have broken DMA.  I've given up
with the idea of getting DMA working on any of these platforms, and as
yet I've not had a response from the ARM Support request which Catalin
logged for me on this subject.

I don't believe it is possible for MMCI to ever work correctly with DMA
on ARM development platforms.
