From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 02 Apr 2015 14:30:51 +0200
Subject: [PATCH 2/2] ARM: dts: Use last parent for clocks during power
 domain on/off
In-Reply-To: <1427961979-29477-2-git-send-email-k.kozlowski@samsung.com>
References: <1427961979-29477-1-git-send-email-k.kozlowski@samsung.com>
 <1427961979-29477-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <551D367B.2020104@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 04/02/2015 10:06 AM, Krzysztof Kozlowski wrote:
> Replace fixed parent with last parent (obtained with clk_get_parent())
> of clocks for devices in mfc and disp power domains. This should improve
> behavior if such clocks were reparented by the drivers and new parents
> are different than those specified in DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

On an Exynos5420 Peach Pit Chromebook:

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
