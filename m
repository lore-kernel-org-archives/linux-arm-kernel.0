From: tony@atomide.com (Tony Lindgren)
Date: Tue, 28 Nov 2017 06:53:19 -0800
Subject: [PATCH] ARM: dts: am437x-cm-t43: Correct the dmas property of spi0
In-Reply-To: <20171101090340.15708-1-peter.ujfalusi@ti.com>
References: <20171101090340.15708-1-peter.ujfalusi@ti.com>
Message-ID: <20171128145319.GW28152@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [171101 02:05]:
> The DMA binding for eDMA needs 2 parameters, not 1.
> The second, missing parameter is the tptc to be used for the channel.

Applying into omap-for-v4.15/fixes thanks.

Tony
