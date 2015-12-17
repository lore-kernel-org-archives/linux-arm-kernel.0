From: davem@davemloft.net (David Miller)
Date: Thu, 17 Dec 2015 15:53:45 -0500 (EST)
Subject: [PATCH] net/macb: Update device tree binding for resetting PHY
 using GPIO
In-Reply-To: <1450345864-10907-1-git-send-email-gregory.clement@free-electrons.com>
References: <874mfhtqnv.fsf@free-electrons.com>
 <1450345864-10907-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20151217.155345.1947787110373074406.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Date: Thu, 17 Dec 2015 10:51:04 +0100

> Instead of being at the MAC level the reset gpio preperty is moved at the
> PHY child node level. It is still managed by the MAC, but from the point
> of view of the binding it make more sense to be part of the PHY node.
> 
> This commit also fixes a build errors if GPIOLIB is not selected.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied to net-next, thanks.

Please be explicit in your patch postings what tree you are targetting
a change at.
