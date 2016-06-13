From: davem@davemloft.net (David Miller)
Date: Sun, 12 Jun 2016 21:58:32 -0400 (EDT)
Subject: [PATCH net-next RFT] net: fec: handle small PHY reset
 durations more precisely
In-Reply-To: <1465418567-2694-1-git-send-email-stefan.wahren@i2se.com>
References: <1465418567-2694-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20160612.215832.1472080008176652824.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Wahren <stefan.wahren@i2se.com>
Date: Wed,  8 Jun 2016 20:42:46 +0000

> Since msleep is based on jiffies the PHY reset could take longer
> than expected. So use msleep for values greater than 20 msec otherwise
> usleep_range.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied.
