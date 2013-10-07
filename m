From: davem@davemloft.net (David Miller)
Date: Mon, 07 Oct 2013 15:19:50 -0400 (EDT)
Subject: [PATCH 1/2] net: ethernet: cpsw: Search childs for slave nodes
In-Reply-To: <1380890680-30941-1-git-send-email-mpa@pengutronix.de>
References: <1380890680-30941-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20131007.151950.425314304695719989.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Pargmann <mpa@pengutronix.de>
Date: Fri,  4 Oct 2013 14:44:39 +0200

> The current implementation searches the whole DT for nodes named
> "slave".
> 
> This patch changes it to search only child nodes for slaves.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Applied.
