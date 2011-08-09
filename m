From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 9 Aug 2011 16:57:24 +0200
Subject: [PATCHv3 7/9] macb: support statistics for GEM devices
In-Reply-To: <1312881411-2376-8-git-send-email-jamie@jamieiles.com>
References: <1312881411-2376-1-git-send-email-jamie@jamieiles.com>
	<1312881411-2376-8-git-send-email-jamie@jamieiles.com>
Message-ID: <20110809145724.GM22213@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:16 Tue 09 Aug     , Jamie Iles wrote:
> GEM devices have a different number of statistics registers and they
> are at a different offset to MACB devices.  Make the statistics
> collection method dependent on device type.
> 
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> Acked-by: David S. Miller <davem@davemloft.net>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
