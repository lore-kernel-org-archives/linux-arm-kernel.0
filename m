From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 17 Sep 2015 16:55:21 +0900
Subject: [PATCH 6/6] pinctrl: samsung: Remove unneded semicolon
In-Reply-To: <1442392111-8448-7-git-send-email-javier@osg.samsung.com>
References: <1442392111-8448-1-git-send-email-javier@osg.samsung.com>
 <1442392111-8448-7-git-send-email-javier@osg.samsung.com>
Message-ID: <55FA71E9.4010402@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.09.2015 17:28, Javier Martinez Canillas wrote:
> It's not needed an is just creating a null statement, so remove it.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  drivers/pinctrl/samsung/pinctrl-exynos5440.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Quite obvious and pointed out by coccicheck, so:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
