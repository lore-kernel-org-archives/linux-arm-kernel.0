From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu, 24 May 2018 11:30:06 +0200
Subject: [PATCH v2 05/13] mtd: rawnand: marvell: remove the dmaengine
 compat need
In-Reply-To: <20180524070703.11901-6-robert.jarzmik@free.fr>
References: <20180524070703.11901-1-robert.jarzmik@free.fr>
 <20180524070703.11901-6-robert.jarzmik@free.fr>
Message-ID: <20180524113006.3d5f393e@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On Thu, 24 May 2018 09:06:55 +0200, Robert Jarzmik
<robert.jarzmik@free.fr> wrote:

> As the pxa architecture switched towards the dmaengine slave map, the
> old compatibility mechanism to acquire the dma requestor line number and
> priority are not needed anymore.
> 
> This patch simplifies the dma resource acquisition, using the more
> generic function dma_request_slave_channel().
> 
> Signed-off-by: Signed-off-by: Daniel Mack <daniel@zonque.org>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/mtd/nand/raw/marvell_nand.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu?l
