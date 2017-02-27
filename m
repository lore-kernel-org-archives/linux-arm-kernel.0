From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 13:12:31 -0600
Subject: [PATCH v2 2/3] mtd: nand: atmel: Document the new DT bindings
In-Reply-To: <1487593718-20752-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1487593718-20752-1-git-send-email-boris.brezillon@free-electrons.com>
 <1487593718-20752-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20170227191231.qub5boyro2scb362@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 01:28:37PM +0100, Boris Brezillon wrote:
> The old NAND bindings were not exactly describing the hardware topology
> and were preventing definitions of several NAND chips under the same
> NAND controller.
> 
> New bindings address these limitations and should be preferred over the
> old ones for new SoCs/boards.
> Old bindings are still supported for backward compatibility but are
> marked deprecated in the doc.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  .../devicetree/bindings/mtd/atmel-nand.txt         | 107 ++++++++++++++++++++-
>  1 file changed, 106 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
