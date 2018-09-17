From: davem@davemloft.net (David Miller)
Date: Mon, 17 Sep 2018 07:58:13 -0700 (PDT)
Subject: [PATCH] net: macb: disable scatter-gather for macb on sama5d3
In-Reply-To: <20180914154811.12090-1-nicolas.ferre@microchip.com>
References: <20180914154811.12090-1-nicolas.ferre@microchip.com>
Message-ID: <20180917.075813.1145409055019392182.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>
Date: Fri, 14 Sep 2018 17:48:10 +0200

> Create a new configuration for the sama5d3-macb new compatibility string.
> This configuration disables scatter-gather because we experienced lock down
> of the macb interface of this particular SoC under very high load.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied, but are you really sure it isn't just some bug in the driver
or somesuch?
