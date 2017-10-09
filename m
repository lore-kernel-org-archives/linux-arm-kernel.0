From: davem@davemloft.net (David Miller)
Date: Mon, 09 Oct 2017 10:43:20 -0700 (PDT)
Subject: [PATCH] net: thunderx: mark expected switch fall-throughs in
 nicvf_main()
In-Reply-To: <20171009164453.GA4889@embeddedor.com>
References: <20171009164453.GA4889@embeddedor.com>
Message-ID: <20171009.104320.709683794054164260.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Mon, 9 Oct 2017 11:44:53 -0500

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Cc: Sunil Goutham <sgoutham@cavium.com>
> Cc: Robert Richter <rric@kernel.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: netdev at vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
