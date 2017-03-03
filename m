From: robh@kernel.org (Rob Herring)
Date: Fri, 3 Mar 2017 00:21:47 -0600
Subject: [PATCH v4 1/2] dt-bindings: mmc: add DT binding for S3C24XX
 MMC/SD/SDIO controller
In-Reply-To: <1488417536-15110-2-git-send-email-sergio.prado@e-labworks.com>
References: <1488417536-15110-1-git-send-email-sergio.prado@e-labworks.com>
 <1488417536-15110-2-git-send-email-sergio.prado@e-labworks.com>
Message-ID: <20170303062147.gm5bl43zctztpadb@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 01, 2017 at 10:18:55PM -0300, Sergio Prado wrote:
> Adds the device tree bindings description for Samsung S3C24XX
> MMC/SD/SDIO controller, used as a connectivity interface with external
> MMC, SD and SDIO storage mediums.
> 
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> ---
>  .../devicetree/bindings/mmc/samsung,s3cmci.txt     | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt

Acked-by: Rob Herring <robh@kernel.org>
