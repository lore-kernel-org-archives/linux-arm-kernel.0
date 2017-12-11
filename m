From: tony@atomide.com (Tony Lindgren)
Date: Mon, 11 Dec 2017 08:53:10 -0800
Subject: [PATCH] ARM: dts: dra7: Add missing hdmi audio DMA channel
 information
In-Reply-To: <20171108125323.7070-1-peter.ujfalusi@ti.com>
References: <20171108125323.7070-1-peter.ujfalusi@ti.com>
Message-ID: <20171211165310.GO24344@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [171108 04:54]:
> The audio DMA request for hdmi is crossbar 76 and we use sDMA
> to handle the data transfer.

Applying into omap-for-v4.16/dt thanks.

Tony
