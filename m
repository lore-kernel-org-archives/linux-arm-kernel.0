From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 19 Jan 2015 11:45:01 +0100
Subject: [PATCH v2 0/4] dmaengine: at_xdmac: several improvements
In-Reply-To: <1418380615-12171-1-git-send-email-ludovic.desroches@atmel.com>
References: <1418380615-12171-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20150119104501.GD19014@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

Any issue with this patch series?

Regards

Ludovic

On Fri, Dec 12, 2014 at 11:36:51AM +0100, Ludovic Desroches wrote:
> Hi,
> 
> This series is based on vkoul/slave-dma/topic/slave_caps_device_control_fix
> branch.
> 
> Changes from v1:
> - put save_cc field addition in a single patch
> - update commit log of patch 3/4
> - remove AT_XDMAC_CUR_CFG since it is no more used
> 
> Cyrille Pitchen (1):
>   dmaengine: at_xdmac: wait for in-progress transaction to complete
>     after     pausing a channel
> 
> Ludovic Desroches (3):
>   dmaengine: at_xdmac: introduce save_cc field
>   dmaengine: at_xdmac: simplify channel configuration stuff
>   dmaengine: at_xdmac: allow muliple dwidths when doing slave transfers
> 
>  drivers/dma/at_xdmac.c | 60 ++++++++++++++++++++++++++------------------------
>  1 file changed, 31 insertions(+), 29 deletions(-)
> 
> -- 
> 2.0.3
> 
