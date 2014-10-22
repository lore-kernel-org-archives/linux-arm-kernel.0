From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 22 Oct 2014 16:08:47 +0200
Subject: [PATCH 0/4] Make Armada 375 use the reference clock when possible
In-Reply-To: <20141022155614.04d33791@free-electrons.com>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141022155614.04d33791@free-electrons.com>
Message-ID: <20141022140847.GQ9845@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> You don't clearly state whether your patch series keep compatibility
> with the 375 Z1 or not. And in fact, it doesn't keep compatibility with
> Z1.

Hi Thomas

That answers my question. Thanks

> I'm fine with that, but then it means we should officially declare
> the Z1 support in mainline as dead, and get rid of the workarounds that
> applied only to 375 Z1.

A big ACK.

How bad is it if you run these patches on a Z1? Is it worth adding a
revision check and calling BUG()?

	 Andrew
