From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 9 Aug 2011 16:55:57 +0200
Subject: [PATCHv3 5/9] macb: initial support for Cadence GEM
In-Reply-To: <1312881411-2376-6-git-send-email-jamie@jamieiles.com>
References: <1312881411-2376-1-git-send-email-jamie@jamieiles.com>
	<1312881411-2376-6-git-send-email-jamie@jamieiles.com>
Message-ID: <20110809145557.GK22213@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  
>  MODULE_LICENSE("GPL");
> -MODULE_DESCRIPTION("Atmel MACB Ethernet driver");
> -MODULE_AUTHOR("Haavard Skinnemoen (Atmel)");
> +MODULE_DESCRIPTION("Cadence MACB/GEM Ethernet driver");
> +MODULE_AUTHOR("Haavard Skinnemoen");
Haavard do it as a Atmel emloyee so please keep the (Atmel)

otherwise

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
