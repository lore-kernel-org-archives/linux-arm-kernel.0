From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 18:12:15 -0600
Subject: [PATCH v2 02/17] dt-bindings: arm: Document Actions Semi S500
In-Reply-To: <20170224034055.18807-3-afaerber@suse.de>
References: <20170224034055.18807-1-afaerber@suse.de>
 <20170224034055.18807-3-afaerber@suse.de>
Message-ID: <20170228001215.rd4v5frufovwz25s@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2017 at 04:40:40AM +0100, Andreas F?rber wrote:
> The Actions Semi S500 is a quad-core ARM Cortex-A9 SoC.
> The LeMaker Guitar is an SODIMM-format module with that SoC.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v1 -> v2:
>  * Adopted "actions" vendor prefix
>  * Extended text
>  
>  Documentation/devicetree/bindings/arm/actions.txt | 24 +++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/actions.txt

Acked-by: Rob Herring <robh@kernel.org>
