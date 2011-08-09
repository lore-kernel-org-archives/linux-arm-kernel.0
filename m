From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 9 Aug 2011 16:49:01 +0200
Subject: [PATCHv3 1/9] at91: provide macb clks with "pclk" and "hclk" name
In-Reply-To: <1312881411-2376-2-git-send-email-jamie@jamieiles.com>
References: <1312881411-2376-1-git-send-email-jamie@jamieiles.com>
	<1312881411-2376-2-git-send-email-jamie@jamieiles.com>
Message-ID: <20110809144901.GH22213@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:16 Tue 09 Aug     , Jamie Iles wrote:
> The macb driver expects clocks with the names "pclk" and "hclk".  We
> currently provide "macb_clk" but to fit in line with other
> architectures (namely AVR32), provide "pclk" and a fake "hclk".
> 
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> Acked-by: David S. Miller <davem@davemloft.net>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
we now use clkdev

I'll send a updated version

Best Regards,
J.
