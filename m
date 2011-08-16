From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 16 Aug 2011 10:28:30 +0100
Subject: PB1176 broken in -rc1
In-Reply-To: <CACRpkdaoDJy-YKONaz2j07pPvTZuHZ7KgEm6XGxNXK-jNzB8_w@mail.gmail.com>
References: <20110810152400.GO10121@e102144-lin.cambridge.arm.com>
	<CACRpkdaoDJy-YKONaz2j07pPvTZuHZ7KgEm6XGxNXK-jNzB8_w@mail.gmail.com>
Message-ID: <20110816092830.GB2786@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 11:21:50AM +0200, Linus Walleij wrote:
> On Wed, Aug 10, 2011 at 5:24 PM, Will Deacon <will.deacon@arm.com> wrote:
> 
> > Hi Linus,
> >
> > My PB1176 platform appears to lock up as soon as it hits userspace when
> > running a 3.1-rc1 kernel.
> 
> My kernel does not even boot on either -rc1 or -rc2 on the
> PB1176, with or wthout Jamies poisoning fixup.
> 
> Did you change anything else on top of -rc1 when you tested this?
> 
> Will, Jamie, any hints?
> 
> If I cherry-pick my TCM patches adding PB1176 support to a clean
> v3.0 branch, everything works fine, so I suspect I am not guilty for
> this AFAICT, it's something else.

Well I've been basing off of Grant's device tree branches as my platform 
(1176) isn't in mainline yet and has DT dependencies.  Is anything being 
put in your TCMs or are they staying empty?

Jamie
