From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Oct 2016 08:16:14 -0500
Subject: [PATCH 2/3] dt-bindings: mtd: add DT binding for s3c2410 flash
 controller
In-Reply-To: <1475711217-974-3-git-send-email-sergio.prado@e-labworks.com>
References: <1475711217-974-1-git-send-email-sergio.prado@e-labworks.com>
 <1475711217-974-3-git-send-email-sergio.prado@e-labworks.com>
Message-ID: <20161010131614.GA7855@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 05, 2016 at 08:46:56PM -0300, Sergio Prado wrote:
> Adds the device tree bindings description for Samsung S3C2410 and
> compatible NAND flash controller.
> 
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> ---
>  .../devicetree/bindings/mtd/samsung-s3c2410.txt    | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt

Acked-by: Rob Herring <robh@kernel.org>
