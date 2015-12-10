From: sushaanth.s@ti.com (Sushaanth Srirangapathi)
Date: Thu, 10 Dec 2015 17:50:35 +0530
Subject: [PATCH 0/6] ARM: DTS: da850: eDMA new bindings and MMC/SPI DMA
 support
In-Reply-To: <1449237210-16381-1-git-send-email-peter.ujfalusi@ti.com>
References: <1449237210-16381-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <56696E13.2000004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 December 2015 07:23 PM, Peter Ujfalusi wrote:
> Hi,
>
> Switch to use the new eDMA bindings and enable DMA for MMC0, SPI1.
> Add node for MMC1.

Tested MMC0 and SPI1 for DMA transfer using these patches on DA850 EVM.
You can add:

Tested-by: Sushaanth Srirangapathi <sushaanth.s@ti.com>

Regards,
Sushaanth
