From: davem@davemloft.net (David Miller)
Date: Mon, 28 Aug 2017 15:23:00 -0700 (PDT)
Subject: [PATCH 4/4] net: stmmac: sun8i: Remove the compatibles
In-Reply-To: <20170825191217.10278-5-maxime.ripard@free-electrons.com>
References: <20170825191217.10278-1-maxime.ripard@free-electrons.com>
 <20170825191217.10278-5-maxime.ripard@free-electrons.com>
Message-ID: <20170828.152300.453206773958057088.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Fri, 25 Aug 2017 21:12:17 +0200

> Since the bindings have been controversial, and we follow the DT stable ABI
> rule, we shouldn't let a driver with a DT binding that might change slip
> through in a stable release.
> 
> Remove the compatibles to make sure the driver will not probe and no-one
> will start using the binding currently implemented. This commit will
> obviously need to be reverted in due time.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied to net tree.
