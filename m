From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 19 Jun 2014 20:34:00 +0400
Subject: [PATCH] ARM: mvebu: Fix missing binding documentation for Armada
 38x
In-Reply-To: <1403186871-28204-1-git-send-email-gregory.clement@free-electrons.com>
References: <1403186871-28204-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <53A310F8.8090207@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2014 06:07 PM, Gregory CLEMENT wrote:

> For the Armada 380 and Armada 385 SoCs, the common bindings for those
> 2 SoCs, was forgotten. This patch add the documentation for the
> marvell,aramda38x property.

> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> Hi,

> This fix should be merged in 3.16. For 3.15 I am not sure as it is not
> a regression.

> Thanks,
> Gregory

>   Documentation/devicetree/bindings/arm/armada-38x.txt | 4 ++++
>   1 file changed, 4 insertions(+)

> diff --git a/Documentation/devicetree/bindings/arm/armada-38x.txt b/Documentation/devicetree/bindings/arm/armada-38x.txt
> index 11f2330a6554..b68bcb80d2de 100644
> --- a/Documentation/devicetree/bindings/arm/armada-38x.txt
> +++ b/Documentation/devicetree/bindings/arm/armada-38x.txt
> @@ -6,5 +6,9 @@ following property:
>
>   Required root node property:
>
> +compatible: must contain "marvell,armada38x"

    Oh, and the wildcards are a no-no in the "compatible" prop.

WBR, Sergei
