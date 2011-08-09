From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 9 Aug 2011 16:53:34 +0200
Subject: [PATCHv3 3/9] macb: unify at91 and avr32 platform data
In-Reply-To: <1312881411-2376-4-git-send-email-jamie@jamieiles.com>
References: <1312881411-2376-1-git-send-email-jamie@jamieiles.com>
	<1312881411-2376-4-git-send-email-jamie@jamieiles.com>
Message-ID: <20110809145334.GJ22213@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:16 Tue 09 Aug     , Jamie Iles wrote:
> Both at91 and avr32 defines its own platform data structure for
> the macb driver and both share common structures though at91
> includes a currently unused phy_irq_pin.  Create a common
> macb_platform_data for macb that both at91 and avr32 can use.  In
> future we can use this to support other architectures that use the
> same IP block with the macb driver.
> 
> v2: rename eth_platform_data to macb_platform_data and allow at91_ether
> to share the platform data with macb.
not sure we need to keep this in the commit
> 
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
