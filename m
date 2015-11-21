From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 20 Nov 2015 17:36:03 -0800
Subject: [PATCH v8 1/2] mtd: mtk-nor: mtk serial flash controller driver
In-Reply-To: <1447817403-16631-2-git-send-email-bayi.cheng@mediatek.com>
References: <1447817403-16631-1-git-send-email-bayi.cheng@mediatek.com>
 <1447817403-16631-2-git-send-email-bayi.cheng@mediatek.com>
Message-ID: <20151121013603.GG64635@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 11:30:02AM +0800, Bayi Cheng wrote:
> add spi nor flash driver for mediatek controller
> 
> Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>
> ---
>  drivers/mtd/spi-nor/Kconfig       |   7 +
>  drivers/mtd/spi-nor/Makefile      |   1 +
>  drivers/mtd/spi-nor/mtk-quadspi.c | 486 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 494 insertions(+)
>  create mode 100644 drivers/mtd/spi-nor/mtk-quadspi.c

Looks good now. Thanks! Applied to l2-mtd.git, with a trivial whitespace
fixup.
