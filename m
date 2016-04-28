From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 28 Apr 2016 18:38:26 +1000
Subject: [PATCH v2 03/11] doc/devicetree: Add Aspeed clock bindings
In-Reply-To: <4459295.XmBqACy0jk@diego>
References: <1461225849-28074-1-git-send-email-joel@jms.id.au>
 <4956403.scaVRGhPEf@diego>
 <CACPK8XfvLR+yZv77C0Eq=RsPOufrwvQjdPtBhnufNc=eJRLZYg@mail.gmail.com>
 <4459295.XmBqACy0jk@diego>
Message-ID: <1461832706.2791.0.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-04-27 at 11:12 +0200, Heiko St?bner wrote:
> I guess the design would depend on the actual layout of your clock- /
> system-
> controller - aka what else is contained there.

One register controls most clocks so it makes sense to have one driver.

Cheers,
Ben.
