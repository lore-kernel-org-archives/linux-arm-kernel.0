From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 30 Dec 2016 13:06:58 +0300
Subject: [PATCH 1/2] arm64: dma_mapping: allow PCI host driver to limit
 DMA mask
In-Reply-To: <b83c353c-c054-4378-9308-e625c460bdd9@cogentembedded.com>
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
 <b83c353c-c054-4378-9308-e625c460bdd9@cogentembedded.com>
Message-ID: <afde074d-c796-56bd-b337-f285f37414c6@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/30/2016 12:46 PM, Sergei Shtylyov wrote:

>> It is possible that PCI device supports 64-bit DMA addressing, and thus
>> it's driver sets device's dma_mask to DMA_BIT_MASK(64), however PCI host
>
>    Its.
>
>> bridge has limitations on inbound transactions addressing. Example of
>> such setup is NVME
>
>    Isn't it called NVMe?
>
>> SSD device connected to RCAR PCIe controller.
>
>    R=Car.

    Sorry, R-Car. :-)

[...]

MBR, Sergei
