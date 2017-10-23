From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 23 Oct 2017 07:53:07 +0200
Subject: devfreq/exynos-bus: Use common error handling code in
 exynos_bus_target()
In-Reply-To: <59ED4313.701@samsung.com>
References: <CGME20171022134057epcas4p43e6f37b8994c28f6ef240536349811a8@epcas4p4.samsung.com>
 <4a407cd6-020c-1750-019a-6c0ceb40e245@users.sourceforge.net>
 <59ED4313.701@samsung.com>
Message-ID: <e84ea128-d69e-7c77-db3a-44622457f347@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> As I already commented on your other patch related to extcon-max14577,
> this patch might remove the redundant error message.

I hope that more software improvements can be achieved in this design direction.


> But, it makes the code more complicated in side of readability. I prefer existing code.

I prefer to avoid duplicated code a bit more.

Regards,
Markus
