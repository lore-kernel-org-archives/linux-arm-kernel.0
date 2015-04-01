From: slash.tmp@free.fr (Mason)
Date: Wed, 01 Apr 2015 14:47:41 +0200
Subject: Reading twd_base at run-time
In-Reply-To: <20150401121213.GC24899@n2100.arm.linux.org.uk>
References: <55158261.9010108@free.fr> <551586E6.3020200@arm.com>
 <5515BEA5.6040307@free.fr> <20150327205301.GD4019@n2100.arm.linux.org.uk>
 <551BDF69.4020205@free.fr> <20150401121213.GC24899@n2100.arm.linux.org.uk>
Message-ID: <551BE8ED.40308@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2015 14:12, Russell King - ARM Linux wrote:

> On Wed, Apr 01, 2015 at 02:07:05PM +0200, Mason wrote:
>
> I'm sorry, it's not that I don't believe you, it's that ARM Ltd
> employees already have evidence to the contrary, and they should know
> what's possible, they (as a company) designed the hardware and they're
> the ones who have to deal with queries from _all_ the silicon vendors.
> They get to know what the entire ARM ecosystem is doing, what vendors
> get wrong, etc.  They're in a far better position than just one silicon
> vendor to know what's possible and what isn't.

(Disclaimer: I am not a HW engineer.) It seems the above reasoning is
based on a false dichotomy. I assume that the "wiring" of PERIPH_BASE
to CP15 is left up to the implementor. Maybe some implementors just
copy a value, while others wire the actual value?

> So when Mark says something has been seen, I believe him, and that
> trumps what hardware engineers at individual silicon vendors claim.

o_O ?? I have never disputed Marc's evidence.

> And what about the cases where it is possible to probe the hardware on
> some platforms but doing so crashes the kernel on others?  I guess you
> don't care about anything but your own platform - that's the kind of
> message you're putting out...

Why would I post patches here if all I cared about was my own platform?

Anyway, I do feel a lot of animosity, and I apologize if some of my
messages have offended you or others here. Perhaps if you could point
out the offending comments, I could adjust in the future?

Regards.
