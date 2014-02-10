From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 10 Feb 2014 18:53:50 +0100
Subject: [PATCH 6/6] dt: Update binding information for mvebu gating
 clocks with Armada 380/385
In-Reply-To: <1392053569-28037-7-git-send-email-gregory.clement@free-electrons.com>
References: <1392053569-28037-1-git-send-email-gregory.clement@free-electrons.com>
 <1392053569-28037-7-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140210175350.GD9995@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +The following is a list of provided IDs for Armada 380/385:
> +ID	Clock		Peripheral
> +-----------------------------------
> +0	audio		Audio
> +2	ge2		Gigabit Ethernet 2
> +3	ge1		Gigabit Ethernet 1
> +4	ge0		Gigabit Ethernet 0
> +5	pex1		PCIe 1
> +6	pex2		PCIe 2
> +7	pex3		PCIe 3
> +8	pex4		PCIe 0

Is that last one a typo? It at least looks a bit odd.

Thanks
	Andrew
