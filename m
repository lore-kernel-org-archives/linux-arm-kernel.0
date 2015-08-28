From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 28 Aug 2015 09:27:37 +0900
Subject: [PATCH] rtc: Fix module autoload for rtc-{ab8500,max8997,s5m}
 drivers
In-Reply-To: <1440671672-26590-1-git-send-email-javier@osg.samsung.com>
References: <1440671672-26590-1-git-send-email-javier@osg.samsung.com>
Message-ID: <55DFAAF9.3020202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.08.2015 19:34, Javier Martinez Canillas wrote:
> These platform drivers have a platform device ID table but the module
> alias information is not created so module autoloading will not work.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  drivers/rtc/rtc-ab8500.c  | 1 +
>  drivers/rtc/rtc-max8997.c | 1 +
>  drivers/rtc/rtc-s5m.c     | 1 +
>  3 files changed, 3 insertions(+)

Makes sense:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
