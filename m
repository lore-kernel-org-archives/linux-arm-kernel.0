From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 1 Apr 2016 10:24:01 -0400
Subject: [PATCH 01/11] ARM: dts: exynos: Fix DTC unit name warnings in
 cros-adc-thermistors
In-Reply-To: <1459493874-2366-1-git-send-email-k.kozlowski@samsung.com>
References: <1459493874-2366-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <56FE8481.7020202@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 04/01/2016 02:57 AM, Krzysztof Kozlowski wrote:
> Fix following DTC warnings in cros-adc-thermistors:
> Warning (unit_address_vs_reg): Node /adc at 12D10000/ncp15wb473 at 3 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /adc at 12D10000/ncp15wb473 at 4 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /adc at 12D10000/ncp15wb473 at 5 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /adc at 12D10000/ncp15wb473 at 6 has a unit name, but no reg property
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
