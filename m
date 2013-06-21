From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 21 Jun 2013 16:07:51 +0530
Subject: [PATCH v12 09/11] spi: omap2-mcspi: convert to
 dma_request_slave_channel_compat()
In-Reply-To: <51C42A71.1090403@ti.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
 <1371762407-24544-10-git-send-email-joelagnel@ti.com>
 <51C42A71.1090403@ti.com>
Message-ID: <51C42CFF.10002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixing Mark's e-mail.

Mark,

On 6/21/2013 3:56 PM, Sourav Poddar wrote:
> Hi Mark,

> On Friday 21 June 2013 02:36 AM, Joel A Fernandes wrote:
>> From: Matt Porter<mporter@ti.com>
>>
>> Convert dmaengine channel requests to use
>> dma_request_slave_channel_compat(). This supports the DT case of
>> platforms requiring channel selection from either the OMAP DMA or
>> the EDMA engine. AM33xx only boots from DT and is the only user
>> implementing EDMA so in the !DT case we can default to the OMAP DMA
>> filter.
>>
>> Signed-off-by: Matt Porter<mporter@ti.com>
>> Acked-by: Mark Brown<broonie@opensource.wolfsonmicro.com>
>> Signed-off-by: Joel A Fernandes<joelagnel@ti.com>

[...]

> Acked-by: Sourav Poddar <sourav.poddar@ti.com>
> Tested-by: Sourav Poddar <sourav.poddar@ti.com>
> 
> This patch can go independently and does not depend on the rest of the
> series.
> Can these patch be pulled?

We can resend the patch if you don't have it from the mailing list.

Thanks,
Sekhar
