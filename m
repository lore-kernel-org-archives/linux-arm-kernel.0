From: ray.jui@broadcom.com (Ray Jui)
Date: Sat, 8 Oct 2016 14:02:35 -0700
Subject: [PATCH v2] arm64: dts: rename ns2.txt to brcm,ns2.txt
In-Reply-To: <1475959684-18085-1-git-send-email-scott.branden@broadcom.com>
References: <1475959684-18085-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <c0cfffa7-d72a-6acb-c457-cd696e24f2eb@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/8/2016 1:48 PM, Scott Branden wrote:
> Rename ns2.txt to brcm,ns2.txt to match naming convention followed
> by rest of Broadcom binding documentation.
>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  Documentation/devicetree/bindings/arm/bcm/{ns2.txt => brcm,ns2.txt} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/arm/bcm/{ns2.txt => brcm,ns2.txt} (100%)
>
> diff --git a/Documentation/devicetree/bindings/arm/bcm/ns2.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,ns2.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/arm/bcm/ns2.txt
> rename to Documentation/devicetree/bindings/arm/bcm/brcm,ns2.txt
>

Looks good to me!

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
