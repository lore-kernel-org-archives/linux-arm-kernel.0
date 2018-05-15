From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 15 May 2018 11:31:30 +0200
Subject: [PATCH V5 1/4] dt-bindings: pwrap: mediatek: add pwrap support
 for MT6797
In-Reply-To: <1525957319-20557-2-git-send-email-argus.lin@mediatek.com>
References: <1525957319-20557-1-git-send-email-argus.lin@mediatek.com>
 <1525957319-20557-2-git-send-email-argus.lin@mediatek.com>
Message-ID: <2cb5230e-f8be-e0b3-3521-3145ab02a0c1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/10/2018 03:01 PM, argus.lin at mediatek.com wrote:
> From: Argus Lin <argus.lin@mediatek.com>
> 
> We add pwrap support for MT6797 SoCs.
> 

You forgot the Signed-off-by tag.

> ---
>  Documentation/devicetree/bindings/soc/mediatek/pwrap.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> index bf80e3f..f9987c3 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> +++ b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> @@ -19,6 +19,7 @@ IP Pairing
>  Required properties in pwrap device node.
>  - compatible:
>  	"mediatek,mt2701-pwrap" for MT2701/7623 SoCs
> +	"mediatek,mt6797-pwrap" for MT6797 SoCs
>  	"mediatek,mt7622-pwrap" for MT7622 SoCs
>  	"mediatek,mt8135-pwrap" for MT8135 SoCs
>  	"mediatek,mt8173-pwrap" for MT8173 SoCs
> -- 
> 1.8.1.1.dirty
> 
> ************* Email Confidentiality Notice ********************
> The information contained in this e-mail message (including any 
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be 
> conveyed only to the designated recipient(s). Any use, dissemination, 
> distribution, printing, retaining or copying of this e-mail (including its 
> attachments) by unintended recipient(s) is strictly prohibited and may 
> be unlawful. If you are not an intended recipient of this e-mail, or believe 
> that you have received this e-mail in error, please notify the sender 
> immediately (by replying to this e-mail), delete any and all copies of 
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!
> 
