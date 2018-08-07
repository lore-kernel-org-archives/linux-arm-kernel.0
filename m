From: davem@davemloft.net (David Miller)
Date: Tue, 07 Aug 2018 12:38:32 -0700 (PDT)
Subject: [PATCH] net: thunderx: check for failed allocation lmac->dmacs
In-Reply-To: <20180806165045.15707-1-colin.king@canonical.com>
References: <20180806165045.15707-1-colin.king@canonical.com>
Message-ID: <20180807.123832.127388149108997730.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin King <colin.king@canonical.com>
Date: Mon,  6 Aug 2018 17:50:45 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> The allocation of lmac->dmacs is not being checked for allocation
> failure. Add the check.
> 
> Fixes: 3a34ecfd9d3f ("net: thunderx: add MAC address filter tracking for LMAC")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
