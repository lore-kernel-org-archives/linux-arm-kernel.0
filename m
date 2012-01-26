From: davem@davemloft.net (David Miller)
Date: Thu, 26 Jan 2012 17:50:14 -0500 (EST)
Subject: [PATCH V5 3/4] CS89x0 : remove QQ2440 board support from the
 CS89x0 driver
In-Reply-To: <1327610831-26961-1-git-send-email-jaccon.bastiaansen@gmail.com>
References: <1327610831-26961-1-git-send-email-jaccon.bastiaansen@gmail.com>
Message-ID: <20120126.175014.2206132443669941139.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
Date: Thu, 26 Jan 2012 21:47:11 +0100

> The QQ2440 board isn't supported anymore in the kernel, so support
> for this board can be removed from the CS89x0 driver.
> 
> Signed-off-by: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>

I'm fine with this going via one of the ARM trees:

Acked-by: David S. Miller <davem@davemloft.net>
