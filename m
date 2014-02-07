From: davem@davemloft.net (David Miller)
Date: Thu, 06 Feb 2014 19:47:23 -0800 (PST)
Subject: [PATCH 2/3] net: phy: sunxi: Add new compatibles
In-Reply-To: <1391348953-10662-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1391348953-10662-1-git-send-email-maxime.ripard@free-electrons.com>
 <1391348953-10662-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140206.194723.1272161937664295404.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Sun,  2 Feb 2014 14:49:12 +0100

> The Allwinner A10 compatibles were following a slightly different compatible
> patterns than the rest of the SoCs for historical reasons. Add compatibles
> matching the other pattern to the mdio driver for consistency, and keep the
> older one for backward compatibility.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied.
