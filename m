From: davem@davemloft.net (David Miller)
Date: Fri, 14 Mar 2014 22:39:25 -0400 (EDT)
Subject: [PATCH] net: phy: fix uninitalized ethtool_wolinfo in phy_suspend
In-Reply-To: <1394788064-6832-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <20140313.153832.967564223480298567.davem@davemloft.net>
 <1394788064-6832-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140314.223925.1612925351139021751.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date: Fri, 14 Mar 2014 10:07:44 +0100

> Callers of phy_ethtool_get_wol are supposed to provide a properly
> cleared struct ethtool_wolinfo. Therefore, fix phy_suspend to clear
> it before passing it to phy_ethtool_get_wol.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Applied, thanks.
