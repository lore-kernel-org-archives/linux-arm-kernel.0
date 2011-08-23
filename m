From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 23 Aug 2011 16:24:16 -0400 (EDT)
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <20051.59927.511785.371806@mariner.uk.xensource.com>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<CA+wbFdcv_BsHaVwoqgF5yx6scXOodHkKjdVtarqJwjy_GFrAJQ@mail.gmail.com>
	<20051.57581.894859.395981@mariner.uk.xensource.com>
	<20110823174550.GJ3895@n2100.arm.linux.org.uk>
	<20051.59927.511785.371806@mariner.uk.xensource.com>
Message-ID: <alpine.LFD.2.00.1108231604520.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Aug 2011, Ian Jackson wrote:
> Russell King - ARM Linux writes ("Re: ARM processor mode, kernel startup, Hyp / secure state"):
> > Plus, I'd point out that _no one_ is talking about boot protocols.  Not
> > outside linaro at any rate.  Which means that they're doing effective
> > closed-door discussion.
> 
> I'm not sure whether by "outside linaro" you mean "outside some kind
> of top secret Linaro meetings".  I went to an open meeting of Linaro
> developers touching on exactly these kind of topics, and everything
> was public and there was substantial interest.

For the record, this Linaro topic and the progress done is documented here:
https://blueprints.launchpad.net/linaro/+spec/linaro-kernel-o-bootarchitecture

Nothing (yet) in there that would highly passionate you Russell I'm 
afraid.  This is probably why you didn't hear of it before.  But the 
discussion and the mailing list is public and open to anyone interested.

> I'm not a Linaro developer; but I have CC'd their boot-architecture
> list which AIUI is where some of the Linaro folks were thinking of
> discussing boot protocols.
> 
> Just to be clear: I don't have a particular axe to grind, except that
> I would like there to be some kind of defined and reasonably stable
> interface, and that obviously we (Xen.org) need that interface to
> support access to Hyp mode (which is something that Linux needs too if
> we are to have a properly supported KVM on ARM).
> 
> Are linux-arm-kernel at infradead and boot-architecture at linaro the right
> places to try to have this conversation ?

Absolutely.


Nicolas
