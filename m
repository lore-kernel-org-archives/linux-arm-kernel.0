From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 5 Apr 2016 10:02:06 -0400
Subject: [PATCH 1/2] mfd: max77693: Allow building as a module
In-Reply-To: <1459756459-22061-1-git-send-email-k.kozlowski@samsung.com>
References: <1459756459-22061-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5703C55E.1000805@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 04/04/2016 03:54 AM, Krzysztof Kozlowski wrote:
> The consumer of max77693 regulators on Trats2 board (samsung-usb2-phy
> driver) supports deferred probing so the max77693 main MFD driver can be
> built now as a module. This gives more flexibility and removes manual
> ordering of init calls.
> 
> Suggested-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
