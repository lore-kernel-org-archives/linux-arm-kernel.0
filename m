From: koro.chen@mediatek.com (Koro Chen)
Date: Mon, 13 Jul 2015 10:59:55 +0800
Subject: [PATCH 2/2] ASoC: Drop owner assignment from platform_driver
In-Reply-To: <1436506231-8980-3-git-send-email-k.kozlowski@samsung.com>
References: <1436506231-8980-1-git-send-email-k.kozlowski@samsung.com>
 <1436506231-8980-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1436756395.2090.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-07-10 at 14:30 +0900, Krzysztof Kozlowski wrote:
> platform_driver does not need to set an owner because
> platform_driver_register() will set it.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 

Acked-by: Koro Chen <koro.chen@mediatek.com>

Thank you!
