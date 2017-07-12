From: davem@davemloft.net (David Miller)
Date: Wed, 12 Jul 2017 14:42:32 -0700 (PDT)
Subject: [PATCH] net: stmmac: revert "support future possible different
 internal phy mode"
In-Reply-To: <20170712073234.9809-1-clabbe.montjoie@gmail.com>
References: <20170712073234.9809-1-clabbe.montjoie@gmail.com>
Message-ID: <20170712.144232.1239782285136293791.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Wed, 12 Jul 2017 09:32:34 +0200

> Since internal phy-mode is reserved for non-xMII protocol we cannot use
> it with dwmac-sun8i.
> Furthermore, all DT patchs which comes with this patch were cleaned, so
> the current state is broken.
> This reverts commit 1c2fa5f84683 ("net: stmmac: support future possible different internal phy mode")
> 
> Fixes: 1c2fa5f84683 ("net: stmmac: support future possible different internal phy mode")
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Applied, thanks.
