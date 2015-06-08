From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 8 Jun 2015 18:07:23 +0200
Subject: [PATCH v2 0/3] Fixes for at_xdmac
In-Reply-To: <1433751820-26142-1-git-send-email-ludovic.desroches@atmel.com>
References: <1433751820-26142-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <5575BDBB.5000503@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 08/06/2015 10:23, Ludovic Desroches a ?crit :
> Hi Vinod,
> 
> I have updated patch 1 as you requested.
> 
> About patch 2, I don't really find how to split it. I have applied it on 4.0.4
> without any conflicts so backport will not be an issue.
> 
> 
> Changes from v1:
> - remove indentation fixes from patch for stable and put it in another one.
> 
> Ludovic Desroches (3):
>   dmaengine: at_xdmac: lock fixes
>   dmaengine: at_xdmac: rework slave configuration part
>   dmaengine: at_xdmac: fix indentation

For the record, as I added the tags to the previous version:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

>  drivers/dma/at_xdmac.c | 241 +++++++++++++++++++++++++++++--------------------
>  1 file changed, 144 insertions(+), 97 deletions(-)
> 


-- 
Nicolas Ferre
