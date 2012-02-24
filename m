From: davem@davemloft.net (David Miller)
Date: Fri, 24 Feb 2012 03:24:27 -0500 (EST)
Subject: [PATCH] davinci_mdio: Correct bitmask for clock divider value
In-Reply-To: <1329984478-24090-1-git-send-email-christian.riesch@omicron.at>
References: <1329984478-24090-1-git-send-email-christian.riesch@omicron.at>
Message-ID: <20120224.032427.261928925990890713.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christian Riesch <christian.riesch@omicron.at>
Date: Thu, 23 Feb 2012 09:07:58 +0100

> The CLKDIV bitfield in the MDIO Control Register is a 16 bit field,
> therefore the CLKDIV value may range from 0 to 0xffff.
> 
> Signed-off-by: Christian Riesch <christian.riesch@omicron.at>

Also applied to net-next.
