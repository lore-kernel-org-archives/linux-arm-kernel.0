From: davem@davemloft.net (David Miller)
Date: Thu, 30 Nov 2017 09:45:35 -0500 (EST)
Subject: [PATCH] net: stmmac: dwmac-sun8i: fix
 allwinner,leds-active-low handling
In-Reply-To: <20171128164822.29218-1-clabbe.montjoie@gmail.com>
References: <20171128164822.29218-1-clabbe.montjoie@gmail.com>
Message-ID: <20171130.094535.2076025477631745913.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Tue, 28 Nov 2017 17:48:22 +0100

> The driver expect "allwinner,leds-active-low" to be in PHY node, but
> the binding doc expect it to be in MAC node.
> 
> Since all board DT use it also in MAC node, the driver need to search
> allwinner,leds-active-low in MAC node.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

I've read over this discussion and I think the thing to do is for me
to simply apply this to 'net' for now.

Thanks.
