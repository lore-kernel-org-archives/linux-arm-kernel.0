From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 3 May 2012 14:14:03 +0200
Subject: [PATCH 1/1] ARM: kirkwood: Add support for RaidSonic
In-Reply-To: <4FA1A7B3.8070106@gmail.com>
References: <20120501172042.GA13233@lunn.ch>
 <alpine.DEB.2.00.1205011902150.23719@marmot.wormnet.eu>
 <20120501195603.GW25584@lunn.ch>
 <op.wdonrhzb4cuzmg@gonzo.lentin.co.uk> <4FA1A7B3.8070106@gmail.com>
Message-ID: <20120503121403.GC14012@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Andrew, thanks for the review of the ib62x0 patch. Once there is a
> gpio-poweroff driver, should I integrate the adaptations to use it into
> the existing patch or would you like to have a dedicated patch for that?

Hi Simon

As i said, this is nice to have. It should not block your patch. Once
the driver is available, you can submit a follow up patch to make use
of it.

   Andrew
