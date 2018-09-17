From: davem@davemloft.net (David Miller)
Date: Mon, 17 Sep 2018 07:57:57 -0700 (PDT)
Subject: [PATCH] ARM: dts: at91: add new compatibility string for macb
 on sama5d3
In-Reply-To: <20180914154811.12090-2-nicolas.ferre@microchip.com>
References: <20180914154811.12090-1-nicolas.ferre@microchip.com>
 <20180914154811.12090-2-nicolas.ferre@microchip.com>
Message-ID: <20180917.075757.1999375645169903821.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>
Date: Fri, 14 Sep 2018 17:48:11 +0200

> We need this new compatibility string as we experienced different behavior
> for this 10/100Mbits/s macb interface on this particular SoC.
> Backward compatibility is preserved as we keep the alternative strings.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied.
