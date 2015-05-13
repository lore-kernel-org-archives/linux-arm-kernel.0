From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 13 May 2015 17:57:03 +0300
Subject: [PATCH v5 0/8] dmaengine/dra7x: DMA router (crossbar support)
In-Reply-To: <20150509114423.GK3521@localhost>
References: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
 <20150509114423.GK3521@localhost>
Message-ID: <5553663F.9040604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2015 02:44 PM, Vinod Koul wrote:
>> This implementation is not tied to any DMA driver so it is possible to use the
>> framework by other vendors, also ACPI version of binding can be easy enough to
>> be added.
> I have applied all but last change to topic/omap

I can only find 6 patches out of the 8 in topic/omap. Patch 3 - which is the
main reason for this series seams to be missing but the binding document patch
for the ti-dma-crossbar is there.

-- 
P?ter
