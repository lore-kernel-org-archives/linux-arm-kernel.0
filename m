From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Jan 2017 15:14:29 +0100
Subject: [PATCH v2 1/4] dmaengine: pl330: remove pdata based initialization
In-Reply-To: <1483970598-6191-2-git-send-email-m.szyprowski@samsung.com>
References: <1483970598-6191-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170109140325eucas1p2674704b2505517ee532284c58c8a64d1@eucas1p2.samsung.com>
 <1483970598-6191-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <5817651.ni7uemv2Cc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, January 9, 2017 3:03:15 PM CET Marek Szyprowski wrote:
> -
> -extern bool pl330_filter(struct dma_chan *chan, void *param);
> 

One minor comment:
I think the function itself is now also unused and can be removed.

Aside from that, the series looks good to me.

	Arnd
