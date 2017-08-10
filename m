From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Aug 2017 15:35:35 -0500
Subject: [PATCH 1/3] dt-bindings: arm: add SMP enable-method for BCM2836
In-Reply-To: <1502058731-12462-2-git-send-email-stefan.wahren@i2se.com>
References: <1502058731-12462-1-git-send-email-stefan.wahren@i2se.com>
 <1502058731-12462-2-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20170810203535.ujjlo2ctqeg2okai@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 07, 2017 at 12:32:09AM +0200, Stefan Wahren wrote:
> This adds a compatible string "brcm,bcm2836-smp" for Broadcom's
> BCM2836 and BCM2837 to the 32 bit ARM CPU device tree binding.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
