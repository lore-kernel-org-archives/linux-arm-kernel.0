From: davem@davemloft.net (David Miller)
Date: Thu, 15 Nov 2012 02:42:13 -0500 (EST)
Subject: [PATCH v7] Network driver for the Armada 370 and Armada XP ARM
 Marvell SoCs
In-Reply-To: <20121115083319.76483256@skate>
References: <1352905010-24172-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121114.215922.1242337385782766449.davem@davemloft.net>
 <20121115083319.76483256@skate>
Message-ID: <20121115.024213.1356436436054345008.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Thu, 15 Nov 2012 08:33:19 +0100

> Would you mind if we take, with your Ack, the network driver through
> the arm-soc tree, so that we can carry the related patches modifying
> the Device Tree and so on? If not, then I'll send you a pull request
> with just the drivers/net changes, and we'll integrate the ARM-related
> changes through the arm-soc tree, in which we will have the necessary
> dependencies. I'm fine with any of those solutions.

Sure, no problem, take it via the ARM tree:

Acked-by: David S. Miller <davem@davemloft.net>
