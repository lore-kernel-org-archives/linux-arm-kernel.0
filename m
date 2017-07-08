From: davem@davemloft.net (David Miller)
Date: Sat, 08 Jul 2017 11:28:19 +0100 (WEST)
Subject: [PATCH] net: ethernet: mediatek: remove useless code in
 mtk_probe()
In-Reply-To: <20170707202333.GA5114@embeddedgus>
References: <20170707150831.Horde.MYtEbXeqxGS-hTg2bUv3DWt@gator4166.hostgator.com>
 <20170707202333.GA5114@embeddedgus>
Message-ID: <20170708.112819.2140475148838704261.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Fri, 7 Jul 2017 15:23:34 -0500

> Remove useless local variables _match_, _soc_ and the code related.
> 
> Notice that
> 
> const struct of_device_id of_mtk_match[] = {
>         { .compatible = "mediatek,mt2701-eth" },
>         {},
> };
> 
> So match->data is NULL.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Applied, thanks.

If someone needs this they can it back, in a less buggy form.
