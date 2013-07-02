From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 2 Jul 2013 11:01:45 +0800
Subject: [RFC PATCH 01/13] misc: atmel_ssc: add device tree DMA support
In-Reply-To: <1372667978-4718-2-git-send-email-richard.genoud@gmail.com>
References: <1372667978-4718-1-git-send-email-richard.genoud@gmail.com>
 <1372667978-4718-2-git-send-email-richard.genoud@gmail.com>
Message-ID: <51D24299.9050209@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On 7/1/2013 16:39, Richard Genoud wrote:
> The ssc device has to fill the at_dma_slave structure with the
> device tree informations.
> Doing a of_dma_request_slave_channel()+dma_release_channel() for that
> seems wrong (or at least not very clean).

Please hold on of this, as to the ASoC dmaengine will deal with this. 
So, we not need do it manually.

Now, I am working on it. And will send out the patch soon after testing OK.

> Signed-off-by: Richard Genoud<richard.genoud@gmail.com>
> ---
>   drivers/misc/atmel-ssc.c                |   56 +++++++++++++++++++++++++++++++
>   include/linux/atmel-ssc.h               |    2 ++
>   include/linux/platform_data/dma-atmel.h |    2 ++
>   3 files changed, 60 insertions(+)

Best Regards,
Bo Shen
