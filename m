From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 6 Jul 2012 19:17:16 +0800
Subject: [PATCH] ARM: dma: mxs-dma: Export missing symbols from mxs-dma.c
In-Reply-To: <1341573766-12459-1-git-send-email-attila@kinali.ch>
References: <20120706111020.GD12558@shlinux2.ap.freescale.net>
 <1341573766-12459-1-git-send-email-attila@kinali.ch>
Message-ID: <20120706111715.GA9304@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2012 at 07:22:46PM +0800, Attila Kinali wrote:
> mxs-dma.c provides two functions mxs_dma_is_apbh and mxs_dma_is_apbx
> which are used at least in mxs-mmc.c. Building mxs-mmc as module
> fails due to those two symbols not being exported.
> 
> Signed-off-by: Attila Kinali <attila@kinali.ch>
> ---
>  drivers/dma/mxs-dma.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
