From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 30 May 2013 18:39:36 +0200
Subject: [PATCH 3/3] at_hdmac: add FIFO configuration parameter to DMA
 DT binding
In-Reply-To: <51A77F10.8020808@atmel.com>
References: <1369930103-11963-1-git-send-email-ludovic.desroches@atmel.com>
 <1369930103-11963-4-git-send-email-ludovic.desroches@atmel.com>
 <51A77F10.8020808@atmel.com>
Message-ID: <20130530163936.GC23653@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:32 Thu 30 May     , Nicolas Ferre wrote:
> On 30/05/2013 18:08, ludovic.desroches at atmel.com :
> >From: Ludovic Desroches <ludovic.desroches@atmel.com>
> >
> >For most devices the FIFO configuration is the same i.e. when half FIFO size is
> >available/filled, a source/destination request is serviced. But USART devices
> >have to do it when there is enough space/data available to perform a single
> >AHB access so the ASAP configuration.
> >
> >Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> >Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Clear and neat: thanks Ludo.

agreed

can we apply this via AT91 as this depends on some cleanup I did on DT and
could result on some nigthmware conflict

Best Regards,
J.
