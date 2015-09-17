From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Sep 2015 21:51:05 +0200
Subject: [PATCH v8 1/3] usb: make xhci platform driver use 64 bit or 32
 bit DMA
In-Reply-To: <41fbbb49c112705a8c14a342e98bd557c15c8f0c.1442513540.git.dhdang@apm.com>
References: <cover.1442513540.git.dhdang@apm.com>
 <41fbbb49c112705a8c14a342e98bd557c15c8f0c.1442513540.git.dhdang@apm.com>
Message-ID: <6744567.5puXIbHVfS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 September 2015 11:19:46 Duc Dang wrote:
> The xhci platform driver needs to work on systems that
> either only support 64-bit DMA or only support 32-bit DMA.
> Attempt to set a coherent dma mask for 64-bit DMA, and
> attempt again with 32-bit DMA if that fails.
> 
> [dhdang: regenerate the patch over v4.3-rc1 and address new comments]
> Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Duc Dang <dhdang@apm.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
