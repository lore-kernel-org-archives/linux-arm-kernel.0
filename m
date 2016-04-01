From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 1 Apr 2016 13:50:34 -0400
Subject: [PATCH 11/11] ARM: dts: s5p: Fix DTC unit name warnings in
 S5Pv210 boards
In-Reply-To: <1459493874-2366-11-git-send-email-k.kozlowski@samsung.com>
References: <1459493874-2366-1-git-send-email-k.kozlowski@samsung.com>
 <1459493874-2366-11-git-send-email-k.kozlowski@samsung.com>
Message-ID: <56FEB4EA.6040805@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 04/01/2016 02:57 AM, Krzysztof Kozlowski wrote:
> Fix following DTC warnings in S5Pv210 boards:
> 
> Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
> Warning (unit_address_vs_reg): Node /soc/fimd at f8000000/display-timings/timing at 0 has a unit name, but no reg property
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

[snip]

>  
> -	memory {
> +	memory at 20000000 {

Same comment than patch #4 with regards to the memory nodes.

After removing those, feel free to add:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
