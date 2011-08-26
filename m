From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Aug 2011 16:44:26 +0200
Subject: try_to_freeze() called with IRQs disabled on ARM
In-Reply-To: <20110825145558.GF8883@n2100.arm.linux.org.uk>
References: <20110823220056.GK3895@n2100.arm.linux.org.uk>
	<20110825130907.GO3286@htj.dyndns.org>
	<20110825145558.GF8883@n2100.arm.linux.org.uk>
Message-ID: <201108261644.26329.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 August 2011, Russell King - ARM Linux wrote:
> 
> Arnd, can you test this to make sure your gdb test case still works, and
> Mark, can you test this to make sure it fixes your problem please?

Hi Russell,

The patch in question was not actually from me but from Ulrich Weigand,
so he's probably the right person to test your patch.
I'm forwarding it in full to Uli for reference.

	Arnd
