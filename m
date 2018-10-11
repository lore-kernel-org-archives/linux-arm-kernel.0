From: robh@kernel.org (Rob Herring)
Date: Thu, 11 Oct 2018 17:17:30 -0500
Subject: [PATCH v4 2/5] dt-bindings: spi: add binding file for NXP
 FlexSPI  controller
In-Reply-To: <1539255519-1408-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539255519-1408-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1539255519-1408-3-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <20181011221730.GA7293@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 11 Oct 2018 11:00:38 +0000, Yogesh Narayan Gaur wrote:
> Add binding file for NXP FlexSPI controller
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
> Changes for v4:
> - Incorporated Rob review comments.
> Changes for v3:
> - Removed node property 'big-endian'.
> Changes for v2:
> - Incorporated Rob review comments.
> 
>  .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
