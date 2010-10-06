From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 6 Oct 2010 10:24:22 +0200
Subject: [PATCH 4/4] dmaengine: Add Freescale i.MX1/21/27 DMA driver
In-Reply-To: <4CABB1B9.4080002@intel.com>
References: <1285854995-6569-1-git-send-email-s.hauer@pengutronix.de>
	<1285854995-6569-5-git-send-email-s.hauer@pengutronix.de>
	<4CABB1B9.4080002@intel.com>
Message-ID: <20101006082422.GT28242@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 05, 2010 at 04:16:09PM -0700, Dan Williams wrote:
>> +       unsigned int                    channel;
>> +       unsigned int                    imxdma_channel;
>> +
>> +       enum dma_data_direction         direction;
>
> Why does the channel have a direction isn't that a function of the  
> transaction?  It's also unused.
>
>> +       enum dma_slave_buswidth         word_size;
>> +       dma_addr_t                      bd_phys;
>
> unused?
>
>> +       unsigned long                   flags;
>
> unused?

Sorry, it seems I was a bit too fast posting it. I'll send an updated
version.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
