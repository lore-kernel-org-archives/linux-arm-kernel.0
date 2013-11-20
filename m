From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 20 Nov 2013 22:13:34 +0200
Subject: [PATCH 0/7] Davinci nand driver fixes and updates
In-Reply-To: <1384960945-14528-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1384960945-14528-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <528D17EE.50402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2013 05:22 PM, Ivan Khoronzhuk wrote:
> This series contains fixes and updates of Davinci nand driver, in
> order to prepare it to be reused for Keystone platform.
>
> V1:
> https://lkml.org/lkml/2013/11/11/352
>
> Ivan Khoronzhuk (7):
>    mtd: nand: davinci: fix driver registration
>    mtd: nand: davinci: return ENOMEM if memory allocation is failed
>    mtd: nand: davinci: check required ti,davinci-chipselect property
>    mtd: nand: davinci: simplify error handling
>    mtd: nand: davinci: move bindings under mtd
>    mtd: nand: davinci: extend description of bindings
>    mtd: nand: davinci: adjust DT properties to MTD generic

For overall series:
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

>
>   .../devicetree/bindings/arm/davinci/nand.txt       |   46 ----------
>   .../devicetree/bindings/mtd/davinci-nand.txt       |   92 ++++++++++++++++++++
>   drivers/mtd/nand/davinci_nand.c                    |   68 +++++++--------
>   3 files changed, 126 insertions(+), 80 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/arm/davinci/nand.txt
>   create mode 100644 Documentation/devicetree/bindings/mtd/davinci-nand.txt
>
