From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Feb 2016 22:43:24 +0100
Subject: [GIT PULL] DaVinci EDMA enhancements for v4.6
In-Reply-To: <1456221214-18042-2-git-send-email-nsekhar@ti.com>
References: <1456221214-18042-1-git-send-email-nsekhar@ti.com>
 <1456221214-18042-2-git-send-email-nsekhar@ti.com>
Message-ID: <3099721.fE27jmolfX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 February 2016 15:23:34 Sekhar Nori wrote:
> Pass dma_slave_map data to EDMA driver. This will help
> migration to new DMA engine API for requesting
> slave channels dma_request_chan().

Pulled into next/soc, thanks!

	Arnd
