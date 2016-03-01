From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 Mar 2016 21:03:02 +0530
Subject: [PATCH v2] ARM: DaVinci USB: removed deprecated properties from
 MUSB config
In-Reply-To: <1456328509-17839-1-git-send-email-petr@barix.com>
References: <1456328509-17839-1-git-send-email-petr@barix.com>
Message-ID: <56D5B62E.8050604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 February 2016 09:11 PM, Petr Kulhavy wrote:
> The following properties of the musb_hdrc_config structure
> are deprecated and no longer required/used by the MUSB driver:
> 
> .dyn_fifo
> .soft_con
> .dma
> .dma_channels
> .eps_bits
> 
> Signed-off-by: Petr Kulhavy <petr@barix.com>

Hi Petr, the patch looks good to me. I have already sent my pull
requests for v4.6 and dont plan on sending any more. I will queue this
for v4.7

Thanks,
Sekhar
