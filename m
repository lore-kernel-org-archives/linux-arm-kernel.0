From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Dec 2016 11:09:03 -0600
Subject: [PATCH 3/5] Documentation: dt: mtd: add chip support for "jedec,
 spi-nor"
In-Reply-To: <1481188984-43683-4-git-send-email-yao.yuan@freescale.com>
References: <1481188984-43683-1-git-send-email-yao.yuan@freescale.com>
 <1481188984-43683-4-git-send-email-yao.yuan@freescale.com>
Message-ID: <20161212170903.ixr6iu4c5txzreub@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2016 at 05:23:02PM +0800, Yuan Yao wrote:
> From: Yuan Yao <yao.yuan@nxp.com>

The compatible string is wrong in the subject.

> 
> "sst25wf040b" and "en25s64" are also chip compatible with SPI NOR flash.
> 
> Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
> ---
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt | 2 ++
>  1 file changed, 2 insertions(+)

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
