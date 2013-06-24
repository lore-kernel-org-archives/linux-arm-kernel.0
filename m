From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 24 Jun 2013 17:09:41 +0530
Subject: [PATCH v12 00/11] DMA Engine support for AM33XX
In-Reply-To: <20130624101903.GV5523@atomide.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
 <20130624101903.GV5523@atomide.com>
Message-ID: <51C82FFD.1070100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sourav,

On 6/24/2013 3:49 PM, Tony Lindgren wrote:
> Hi,
> 
> For merging this series, I suggest the following sets:
> 
> * Joel A Fernandes <joelagnel@ti.com> [130620 14:13]:

>>   spi: omap2-mcspi: add generic DMA request support to the DT binding
>>   spi: omap2-mcspi: convert to dma_request_slave_channel_compat()
> 
> 
> The spi changes should get merged via the driver list.

Can you please send just the DT binding patch above to Mark's correct
address with the relevant lists copied.

Thanks,
Sekhar
