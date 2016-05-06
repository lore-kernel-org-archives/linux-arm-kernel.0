From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Fri, 06 May 2016 10:04:32 +0200
Subject: [PATCH v6 2/9] mfd: max8997: Use regmap to access registers
In-Reply-To: <1462519636-3250-1-git-send-email-k.kozlowski@samsung.com>
References: <1462519289-2356-2-git-send-email-k.kozlowski@samsung.com>
 <1462519636-3250-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <572C5010.1090102@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 05/06/2016 09:27 AM, Krzysztof Kozlowski wrote:
> From: Robert Baldyga <r.baldyga@samsung.com>
>
> This patch modifies max8997 driver and each associated function driver,
> to use regmap instead of operating directly on i2c bus. It will allow to
> simplify IRQ handling using regmap-irq.
>
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
> [For extcon part]
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>
> [For leds part]
> Acked-by: Bryan Wu <cooloney@gmail.com>
>

Since I've replaced Bryan on the position of LED subsystem maintainer
feel free to use my ack:

Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>

-- 
Best regards,
Jacek Anaszewski
