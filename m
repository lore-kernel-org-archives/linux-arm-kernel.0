From: davem@davemloft.net (David Miller)
Date: Thu, 26 Jan 2012 17:49:51 -0500 (EST)
Subject: [PATCH V5 1/4] CS89x0 : add platform driver support
In-Reply-To: <1327610775-26893-1-git-send-email-jaccon.bastiaansen@gmail.com>
References: <1327610775-26893-1-git-send-email-jaccon.bastiaansen@gmail.com>
Message-ID: <20120126.174951.1458396120409651458.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
Date: Thu, 26 Jan 2012 21:46:15 +0100

> The CS89x0 ethernet controller is used on a number of evaluation
> boards, such as the MX31ADS. The current driver has memory address and
> IRQ settings for each board on which this controller is used. Driver
> updates are therefore required to support other boards that also use
> the CS89x0. To avoid these driver updates, a better mechanism
> (platform driver support) is added to communicate the board dependent
> settings to the driver.
> 
> Signed-off-by: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>

I'm fine with this going via one of the ARM trees:

Acked-by: David S. Miller <davem@davemloft.net>
