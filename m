From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 9 Aug 2011 16:59:01 +0200
Subject: [PATCHv3 9/9] macb: allow GEM to have configurable receive
	buffer size
In-Reply-To: <1312881411-2376-10-git-send-email-jamie@jamieiles.com>
References: <1312881411-2376-1-git-send-email-jamie@jamieiles.com>
	<1312881411-2376-10-git-send-email-jamie@jamieiles.com>
Message-ID: <20110809145901.GO22213@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:16 Tue 09 Aug     , Jamie Iles wrote:
> GEM has configurable receive buffer sizes so requires this to be
> programmed up.  Any size < 2048 and a multiple of 64 bytes is permitted.
> 
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> Acked-by: David S. Miller <davem@davemloft.net>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
