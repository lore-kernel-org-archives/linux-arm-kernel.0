From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 1 Apr 2016 13:25:34 -0400
Subject: [PATCH 07/11] ARM: dts: exynos: Fix DTC unit name warnings in
 Exynos542x
In-Reply-To: <1459493874-2366-7-git-send-email-k.kozlowski@samsung.com>
References: <1459493874-2366-1-git-send-email-k.kozlowski@samsung.com>
 <1459493874-2366-7-git-send-email-k.kozlowski@samsung.com>
Message-ID: <56FEAF0E.10900@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 04/01/2016 02:57 AM, Krzysztof Kozlowski wrote:
> Fix following DTC warnings in all Exynos542x/5800 boards:
> 
> Warning (unit_address_vs_reg): Node /video-phy at 10040728 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /video-phy at 10040714 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /usb at 12000000 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /usb at 12000000/dwc3 has a reg or ranges property, but no unit name
> Warning (unit_address_vs_reg): Node /usb at 12400000 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /usb at 12400000/dwc3 has a reg or ranges property, but no unit name
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
