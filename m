From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Mon, 24 Mar 2014 21:34:38 +0100
Subject: [PATCH RFC] ixp4xx_eth: Allow setting the MDIO bus name in
 platform data
In-Reply-To: <20140324151729.1b8e3bb5@marrow.netinsight.se> ("Simon
 =?utf-8?B?S8OlZ3N0csO2bSIncw==?= message of "Mon, 24 Mar 2014 15:17:29
 +0100")
References: <20140324151729.1b8e3bb5@marrow.netinsight.se>
Message-ID: <m3r45r72u9.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon K?gstr?m <simon.kagstrom@netinsight.net> writes:

> Allows using e.g., a fixed MDIO bus with the ixp4xx_eth driver.
> Example:
>
>   static struct eth_plat_info board_plat_eth_internal[] = {
> 	{
> 		.mdio_bus_id	= "fixed-0",
> 		.phy		= 31,
> 		.rxq		= 4,
> 		.txreadyq	= 21,
> 		.hwaddr		= {0x02, 0x00, 0x00, 0x00, 0x00, 0x00},
> 	}
>   };

Why do we need it? I'm not sure I know what constitutes a "fixed MDIO
bus".
-- 
Krzysztof Halasa
