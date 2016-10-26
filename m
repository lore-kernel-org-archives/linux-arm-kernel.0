From: robh@kernel.org (Rob Herring)
Date: Wed, 26 Oct 2016 18:19:12 -0500
Subject: [PATCH v3 2/3] dt-bindings: mtd: add DT binding for s3c2410
 flash controller
In-Reply-To: <1476999766-32526-3-git-send-email-sergio.prado@e-labworks.com>
References: <1476999766-32526-1-git-send-email-sergio.prado@e-labworks.com>
 <1476999766-32526-3-git-send-email-sergio.prado@e-labworks.com>
Message-ID: <20161026231912.z6yez3posjqkqtxu@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 07:42:45PM -0200, Sergio Prado wrote:
> Adds the device tree bindings description for Samsung S3C2410 and
> compatible NAND flash controller.
> 
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> ---
>  .../devicetree/bindings/mtd/samsung-s3c2410.txt    | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt

Acked-by: Rob Herring <robh@kernel.org>
