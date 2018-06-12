From: davem@davemloft.net (David Miller)
Date: Tue, 12 Jun 2018 15:36:40 -0700 (PDT)
Subject: [PATCH] net: stmmac: dwmac-meson8b: Fix an error handling path
 in 'meson8b_dwmac_probe()'
In-Reply-To: <20180611175227.27509-1-christophe.jaillet@wanadoo.fr>
References: <20180611175227.27509-1-christophe.jaillet@wanadoo.fr>
Message-ID: <20180612.153640.206354770292248454.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Mon, 11 Jun 2018 19:52:27 +0200

> If 'of_device_get_match_data()' fails, we need to release some resources as
> done in the other error handling path of this function.
> 
> Fixes: efacb568c962 ("net: stmmac: dwmac-meson: extend phy mode setting")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied.
