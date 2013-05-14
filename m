From: davem@davemloft.net (David Miller)
Date: Tue, 14 May 2013 11:33:19 -0700 (PDT)
Subject: [PATCHv2] mv643xx_eth: fix NAPI weight being > 64
In-Reply-To: <1368525260-17556-1-git-send-email-andrew@lunn.ch>
References: <1368525260-17556-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130514.113319.1597275156031821180.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 14 May 2013 11:54:20 +0200

> 3.10-rc1 issues the following warning:
> 
> netif_napi_add() called with weight 128 on device eth%d
> 
> This patch reduce the weight to 64, using NAPI_POLL_WEIGHT.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Applied.
