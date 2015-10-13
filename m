From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 13 Oct 2015 09:20:31 +0900
Subject: [PATCH 06/37] ARM: dts: s5pv210-goni: Fix typo in regulator enable
 GPIO property
In-Reply-To: <1444684386-17094-7-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1444684386-17094-7-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <561C4E4F.1070604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.10.2015 06:12, Laurent Pinchart wrote:
> The property name should be "gpio", not "gpios". Fix it.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  arch/arm/boot/dts/s5pv210-goni.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
