From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 5 May 2016 15:14:55 -0400
Subject: [RFC v2 06/13] power: pwrseq: Generalize mmc_pwrseq operations by
 removing mmc prefix
In-Reply-To: <1462451666-17945-7-git-send-email-k.kozlowski@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <1462451666-17945-7-git-send-email-k.kozlowski@samsung.com>
Message-ID: <2c763750-9b32-d782-e5a2-4a259c085ed0@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/05/2016 08:34 AM, Krzysztof Kozlowski wrote:
> The power sequence hooks (mmc_pwrseq_pre_power_on(),
> mmc_pwrseq_post_power_on() and mmc_pwrseq_power_off()) can be made more
> generic to allow re-use in other subsystems. They do not need to take
> pointer to struct mmc_host but instead the struct pwrseq should be
> sufficient.
> 
> Remove the "mmc" prefix and use the pointer to struct pwrseq as
> argument.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
