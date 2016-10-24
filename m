From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 24 Oct 2016 15:23:36 +0800
Subject: [PATCH v1 1/2] ARM: dts: vfxxx: Enable DMA for DSPI on Vybrid
In-Reply-To: <63fc108e2df00d2297a9b7014955f203bc802f34.1475498805.git.maitysanchayan@gmail.com>
References: <63fc108e2df00d2297a9b7014955f203bc802f34.1475498805.git.maitysanchayan@gmail.com>
Message-ID: <20161024072336.GZ30578@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2016 at 06:20:37PM +0530, Sanchayan Maity wrote:
> Enable DMA for DSPI on Vybrid.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>

This is a hardware description which looks correct, regardless of the
DSPI driver readiness.  So I applied it.

Shawn
