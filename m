From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 9 Aug 2011 16:57:55 +0200
Subject: [PATCHv3 8/9] macb: support DMA bus widths > 32 bits
In-Reply-To: <1312881411-2376-9-git-send-email-jamie@jamieiles.com>
References: <1312881411-2376-1-git-send-email-jamie@jamieiles.com>
	<1312881411-2376-9-git-send-email-jamie@jamieiles.com>
Message-ID: <20110809145755.GN22213@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:16 Tue 09 Aug     , Jamie Iles wrote:
> Some GEM implementations may support DMA bus widths up to 128 bits.  We
> can get the maximum supported DMA bus width from the design
> configuration register so use that to program the device up.
> 
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> Acked-by: David S. Miller <davem@davemloft.net>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
