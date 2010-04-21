From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 22 Apr 2010 07:09:57 +1000
Subject: orion5x and GPIO blink question
In-Reply-To: <alpine.LFD.2.00.1004211020010.7232@xanadu.home>
References: <1271836632.2330.128.camel@pasglop>
	<alpine.LFD.2.00.1004211020010.7232@xanadu.home>
Message-ID: <1271884197.2330.158.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-04-21 at 10:29 -0400, Nicolas Pitre wrote:
> > Another solution might be to be a bit smarter and have leds-gpio
> > implement a different set_blink() function that takes an additional
> > enable/disable argument, and would call that whenever set_brightness is
> > called on a currently blinking GPIO.
> > 
> > But that means fixing all the in-tree users of leds-gpio set_blink()
> > callback (I haven't counted, but it should be easily greppable).
> > 
> > Opinions ?
> 
> I always have a preference for fixing things properly.  And with a quick 
> grep there seems to be very few set_blink in the whole tree.

Ok, fair enough. I'll give that a go later, maybe next week, as time
permits.

Cheers,
Ben.
