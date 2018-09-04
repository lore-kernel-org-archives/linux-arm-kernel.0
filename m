From: robh@kernel.org (Rob Herring)
Date: Mon, 3 Sep 2018 20:20:10 -0500
Subject: [PATCH 1/6] dt-bindings: crypto: Add Freescale Vybrid CRC
In-Reply-To: <20180830171539.20008-2-krzk@kernel.org>
References: <20180830171539.20008-1-krzk@kernel.org>
 <20180830171539.20008-2-krzk@kernel.org>
Message-ID: <20180904012005.GA2470@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Aug 2018 19:15:34 +0200, Krzysztof Kozlowski wrote:
> Add bindings for Freescale/NXP Vybrid CRC HW accelerator.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/crypto/fsl-vf610-crc.txt         | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/fsl-vf610-crc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
