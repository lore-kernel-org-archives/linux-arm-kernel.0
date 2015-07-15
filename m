From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 15 Jul 2015 16:23:00 +0900
Subject: [PATCH v2 2/2] ASoC: Drop owner assignment from platform_driver
In-Reply-To: <1436934105-12700-2-git-send-email-k.kozlowski@samsung.com>
References: <1436934105-12700-1-git-send-email-k.kozlowski@samsung.com>
 <1436934105-12700-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <55A60A54.7040004@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.07.2015 13:21, Krzysztof Kozlowski wrote:
> platform_driver does not need to set an owner because
> platform_driver_register() will set it.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---
> 
> Changes since v1:
> 1. None
> ---

D'oh! I forgot to include ack from Koro Chen given here:
https://lkml.org/lkml/2015/7/12/218

Please accept my apologies,
Krzysztof
