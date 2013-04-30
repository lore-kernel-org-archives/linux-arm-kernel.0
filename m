From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 30 Apr 2013 14:18:25 +0530
Subject: [PATCH v3 1/6] at_hdmac: move to generic DMA binding
In-Reply-To: <51750F68.4040701@atmel.com>
References: <1366362683-14496-1-git-send-email-ludovic.desroches@atmel.com>
 <1366362683-14496-2-git-send-email-ludovic.desroches@atmel.com>
 <51750F68.4040701@atmel.com>
Message-ID: <20130430084825.GA1960@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 12:22:32PM +0200, Nicolas Ferre wrote:
> On 04/19/2013 11:11 AM, ludovic.desroches at atmel.com :
> > From: Ludovic Desroches <ludovic.desroches@atmel.com>
> > 
> > Update at_hdmac driver to support generic DMA device tree binding. Devices
> > can still request channel with dma_request_channel() then it doesn't break
> > DMA for non DT boards.
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
Applied now thanks

--
~Vinod
