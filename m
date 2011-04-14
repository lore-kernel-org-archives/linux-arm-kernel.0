From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Apr 2011 11:00:48 +0100
Subject: [PATCH 0/2] Common struct clk implementation, v14
In-Reply-To: <1302754859.2767.30.camel@pororo>
References: <1299134429.100626.661279191478.0.gpush@pororo>
	<1302754859.2767.30.camel@pororo>
Message-ID: <20110414100048.GB1611@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2011 at 12:20:59PM +0800, Jeremy Kerr wrote:
> Any updates on these patches? I've added to your patch-tracker, would
> you expect these to make the next merge window, or are there changes
> you'd like made first?
> 
> Reason I ask is that I have a few queries from platform maintainers that
> would like to complete their clock ports to this API, but don't want to
> commit until the interface has been accepted, in at least an initial
> form.

I will take it, but at the moment I'm rather unhappy about the response
from the community to Linus' complaint.

If existing platform maintainers can show that moving over to this will
result in a net reduction of code under arch/arm, then that will be good.
What I don't want to see at the moment is arch/arm increasing in size as
a result of any change.  We desperately need to see a reduction for the
next merge window.
