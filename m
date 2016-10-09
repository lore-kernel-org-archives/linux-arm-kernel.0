From: robh@kernel.org (Rob Herring)
Date: Sat, 8 Oct 2016 20:28:18 -0500
Subject: [PATCH 3/3] bindings: add compatible "fsl, ls1043-ucc-hdlc" to
 bindings
In-Reply-To: <1475034038-7217-3-git-send-email-qiang.zhao@nxp.com>
References: <1475034038-7217-1-git-send-email-qiang.zhao@nxp.com>
 <1475034038-7217-3-git-send-email-qiang.zhao@nxp.com>
Message-ID: <20161009012818.GA18158@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2016 at 11:40:38AM +0800, Zhao Qiang wrote:
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
>  Documentation/devicetree/bindings/soc/fsl/cpm_qe/network.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/network.txt b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/network.txt
> index 03c7416..325e3e2 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/network.txt
> +++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/network.txt
> @@ -45,7 +45,7 @@ Example:
>  * HDLC
>  
>  Currently defined compatibles:
> -- fsl,ucc-hdlc
> +- "fsl,ucc-hdlc", "fsl,ls1043-ucc-hdlc"

What's the relationship of these 2 compatibles? Both should be specified 
for LS1043 or ...? The former only applies to certain SoCs? Rework this 
text to answer these questions.

Rob
