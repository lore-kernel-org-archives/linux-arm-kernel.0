From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 10 May 2016 08:04:40 +1000
Subject: [PATCH 1/2] doc/devicetree: Add Aspeed VIC bindings
In-Reply-To: <20160509152003.GA13842@leverpostej>
References: <1462797239-14765-1-git-send-email-joel@jms.id.au>
 <1462797239-14765-2-git-send-email-joel@jms.id.au>
 <20160509152003.GA13842@leverpostej>
Message-ID: <1462831480.20290.120.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-05-09 at 16:20 +0100, Mark Rutland wrote:
>?
> Generally we steer clear of this kind of bitmap encoding in DT.
> 
> Is this actually necessary? What does htis gain us?
> 
> Why can we not just register with the full set of possible
> interrupts?

Trying to remember why I did that ... I think it has to do with
supporting multiple SoCs that have different possible sources...

There might also be a case of some sources routed to the internal
coldfire microcontroller or the LPC bus instead of the ARM but I'm not
100% certain.

Cheers,
Ben.
