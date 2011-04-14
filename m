From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 14 Apr 2011 20:25:05 +1000
Subject: [PATCH 0/2] Common struct clk implementation, v14
In-Reply-To: <20110414100048.GB1611@n2100.arm.linux.org.uk>
References: <1299134429.100626.661279191478.0.gpush@pororo>
	<1302754859.2767.30.camel@pororo>
	<20110414100048.GB1611@n2100.arm.linux.org.uk>
Message-ID: <1302776705.28876.113.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-04-14 at 11:00 +0100, Russell King - ARM Linux wrote:
> 
> I will take it, but at the moment I'm rather unhappy about the response
> from the community to Linus' complaint.
> 
> If existing platform maintainers can show that moving over to this will
> result in a net reduction of code under arch/arm, then that will be good.
> What I don't want to see at the moment is arch/arm increasing in size as
> a result of any change.  We desperately need to see a reduction for the
> next merge window.

It's a chicken and egg... platform maintainers wait for you to take it
and you wait for them to take it :-)

It seems to me that this fits well into the category of "better common
abstractions" that was discussed in the thread initiated by Linus as one
of the ways to improve on the "clutter"...

Cheers,
Ben.
