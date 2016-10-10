From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Oct 2016 16:44:43 -0500
Subject: [PATCH v2] arm64: dts: rename ns2.txt to brcm,ns2.txt
In-Reply-To: <1475959684-18085-1-git-send-email-scott.branden@broadcom.com>
References: <1475959684-18085-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <20161010214443.GA17115@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 08, 2016 at 01:48:04PM -0700, Scott Branden wrote:
> Rename ns2.txt to brcm,ns2.txt to match naming convention followed
> by rest of Broadcom binding documentation.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  Documentation/devicetree/bindings/arm/bcm/{ns2.txt => brcm,ns2.txt} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/arm/bcm/{ns2.txt => brcm,ns2.txt} (100%)

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm/ns2.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,ns2.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/arm/bcm/ns2.txt
> rename to Documentation/devicetree/bindings/arm/bcm/brcm,ns2.txt
> -- 
> 2.5.0
> 
