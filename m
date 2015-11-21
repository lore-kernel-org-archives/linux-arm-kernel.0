From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sat, 21 Nov 2015 15:26:09 +0100
Subject: [PATCH v3 1/3] ARM: dts: enable clock support for BCM5301X
In-Reply-To: <1448032640-27713-2-git-send-email-jonmason@broadcom.com>
References: <1448032640-27713-1-git-send-email-jonmason@broadcom.com>
 <1448032640-27713-2-git-send-email-jonmason@broadcom.com>
Message-ID: <56507F01.8080807@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2015 04:17 PM, Jon Mason wrote:
> Replace current device tree dummy clocks with real clock support for
> Broadcom Northstar SoCs.
> 
> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> ---
>  arch/arm/boot/dts/bcm5301x.dtsi | 92 +++++++++++++++++++++++++++++++----------
>  1 file changed, 71 insertions(+), 21 deletions(-)
> 

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
