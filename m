From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 29 Feb 2016 08:26:12 +0000
Subject: [PATCH v2 00/17] KVM/ARM: Guest Entry/Exit optimizations
In-Reply-To: <AM2PR04MB073947192D0A7015739689EF84BA0@AM2PR04MB0739.eurprd04.prod.outlook.com>
References: <1455727249-24752-1-git-send-email-marc.zyngier@arm.com>
 <AM2PR04MB073947192D0A7015739689EF84BA0@AM2PR04MB0739.eurprd04.prod.outlook.com>
Message-ID: <56D400A4.3020904@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/02/16 00:57, Mihai Claudiu Caraman wrote:
> Reported-by: Mihai Caraman <mihai.caraman@freescale.com>

Reported-by? Where? Did I miss an email (wouldn't surprise me)?

> Tested-by: Mihai Caraman <mihai.caraman@freescale.com>
> 
> 40% improvements here and there will make the difference. 

I'm sceptical that you will see a significant improvement on any
*realistic* workload, but thanks for testing!

	M.
-- 
Jazz is not dead. It just smells funny...
