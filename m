From: davem@davemloft.net (David Miller)
Date: Wed, 10 Sep 2014 13:03:26 -0700 (PDT)
Subject: [PATCH v1] net: ethernet: arc: Don't free Rockchip resources
 before disconnect from phy
In-Reply-To: <1410335473-23573-1-git-send-email-romain.perier@gmail.com>
References: <1410335473-23573-1-git-send-email-romain.perier@gmail.com>
Message-ID: <20140910.130326.265195308573058113.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Romain Perier <romain.perier@gmail.com>
Date: Wed, 10 Sep 2014 07:51:13 +0000

> Free resources before being disconnected from phy and calling core driver is
> wrong and should not happen. It avoids a delay of 4-5s caused by the timeout of
> phy_disconnect().
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>

Applied, thanks.
