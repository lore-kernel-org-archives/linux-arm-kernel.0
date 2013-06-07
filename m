From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 8 Jun 2013 00:08:53 +0200
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <CAPweEDzW60poOYahm31aW3_A=NvZmyBPPPgM9PzdvuPJnju69A@mail.gmail.com>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <1370475609.20454.44.camel@localhost>
 <CAPweEDwS3tR=wh-bZJb3vqR8fVQra=3XxDitowGRdH9c7WRfmQ@mail.gmail.com>
 <1733666.lHUBcfUXq9@flatron> <20130606112723.71ddd70c@skate>
 <CAPweEDzW60poOYahm31aW3_A=NvZmyBPPPgM9PzdvuPJnju69A@mail.gmail.com>
Message-ID: <20130607220853.GR14209@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 07:26:49PM +0100, luke.leighton wrote:
>  maxime: we need to talk :)
> 
>  please tell me in 4 or 5 sentences what you've managed to do so far,
> expanding a little on what thomas says below, more specifically what
> it achieves and/or allows rather than technically what it does
> (suitable for managers and directors in other words), and what plans
> you'd like to see happen.

You mean something like http://linux-sunxi.org/Linux_mainlining_effort ?

You should really do a bit of research before starting a thread like
this one. This webpage has been around for like 9 monthes now on the wiki 
of a community you pretend to represent (even though I fail to get how
you can pretend such thing, but that's another topic).

> > is the maintainer of the mainline Allwinner sunxi
> > effort. It already supports a number of boards, has a pinctrl driver, a
> > GPIO driver, serial port is working, network is working, I2C is
> > working.
> >
> > All in mainline, completely Device Tree based.
> 
>  great.  which version did it first hit, i.e. what will the first
> signs of this be when allwinner begin doing "git pulls"?

3.8, as shown in the wiki page

>  and which boards.  bear in mind that one of those "boards" should
> really be "the total range of products available across hundreds of
> chinese tablet clone manufacturers".
> 
>  specific question: is one of the "boards" the one that tom cubie
> submitted, which covers virtually every android tablet product
> manufactured in the millions by chinese tablet clone manufacturers?

Again, wiki.

> > So isn't this entire discussion completely moot?
> 
>  no because it's totally in isolation from allwinner.  i need to give
> them a heads-up, and get them involved, giving them specific
> incentives [which nobody's yet given!!] for following a particular
> path [or paths] yet to be recommended.
> 
> > The mainline support
> > for sunxi has already started since 6 months or so, and has been Device
> > Tree based from day one.
> 
> to clarify: the *community-driven* mainline support for sunxi.  ok -
> which chips?  sun3i (ARM9), sun4i (Cortex A8), sun5i, sun6i and sun7i
> (Dual-Core Cortex A7)?  which ones are in?

A10, A13 for the moment. I just received hardware with A10s, A20 and A31
that I need to work on, but support should come quite soon. I already
have some patches pending to be tested on an A31 board, but didn't have
as much time as I wanted lately to actually set a proper environment to
test them.

Maxime
